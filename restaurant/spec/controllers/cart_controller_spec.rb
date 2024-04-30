require "rails_helper"

RSpec.describe CartController, type: :controller do
  let!(:city) { FactoryBot.create(:city) }
  let!(:user) { FactoryBot.create(:user, city: city) }
  let!(:demo_user) { FactoryBot.create(:user, city: city) }
  let!(:cart) { Cart.find_by(user_id: user.id) }
  let!(:restaurant_detail) { FactoryBot.create(:restaurant_detail, user: user, city: city) }
  let!(:menu1) { FactoryBot.create(:menu, item_name: "Ice-cream", item_type: "Desert", restaurant_detail: restaurant_detail, available: true) }
  let!(:menu2) { FactoryBot.create(:menu, item_name: "Kingfisher", item_type: "Beverage", restaurant_detail: restaurant_detail, available: true) }
  let!(:cart_item) { create(:cart_item, qty: 2, menu: menu1, cart: cart) }

  describe "View customer cart #show" do
    it "returns successful response with filled cart items" do
      get :show, params: { id: user.id }
      expect(response).to be_successful
      expect(response.body).not_to be_empty
      parsed_response = JSON.parse(response.body)
      parsed_response.each do |cart_item|
        cart = Cart.find(cart_item["cart_id"])
        expect(cart.user_id).to eq(user.id)
      end
      puts "Response Body : #{response.body}"
    end
    it "returns user cart is empty with an error message" do
      get :show, params: { id: demo_user.id }
      expect(response).to have_http_status(:not_found)
      expect(response.body).not_to be_empty
      puts "\n\nResponse Body : #{response.body}"
      expect(response.body).to eq({ "errors" => "User cart is empty" })
    end
  end

  describe "DELETE Cart Item #delete" do
    it "Returns successful response after deleting cart item" do
      menu1.reload
      expect {
        delete :delete, params: { item_id: cart_item.id }
      }.to change(CartItem, :count).by(-1)
      expect(response).to be_successful
      puts "Response Body : #{response.body}"
    end
    it "updates menu stock after deleting cart item" do
      menu1.reload
      initial_stock = menu1.stock
      delete :delete, params: { item_id: cart_item.id }
      menu1.reload
      expect(menu1.stock).to eq(initial_stock + cart_item.qty)
    end
  end

  describe "POST #create" do
    context "Adding menu items into user cart" do
      it "returns successful response after adding cart item" do
        initial_stock = menu2.stock
        expect {
          post :add_cart_items, params: { id: user.id, menu_id: menu2.id, qty: 2 }
        }.to change(CartItem, :count).by(1)
        expect(response).to be_successful
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["price"]).to eq(Menu.find(parsed_response["menu_id"]).price * parsed_response["qty"])
        # Wheather they belong to same city or not
        expect(Menu.find(parsed_response["menu_id"]).restaurant_detail.city_id).to eq(user.city_id)
        menu2.reload
        # Inventory management
        expect(menu2.stock).to eq(initial_stock - parsed_response["qty"])
        puts "Response Body : #{response.body}"
      end
    end
  end
end

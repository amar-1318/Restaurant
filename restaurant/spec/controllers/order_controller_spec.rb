require "rails_helper"

RSpec.describe OrderController, type: :controller do
  let!(:city) { create(:city) }
  let!(:user) { create(:user, city: city) }
  let!(:order) { create(:order, user: user) }
  let!(:restaurant_detail) { create(:restaurant_detail, city: city) }
  let!(:menu) { create(:menu, item_name: "Ice-cream", item_type: "Desert", restaurant_detail: restaurant_detail, available: true) }
  let!(:order_item) { create(:order_item, order: order, menu_id: menu.id, item_name: "Pasta", item_type: "Beverage", qty: 2, total_price: 180) }

  describe "GET #index" do
    it "returns successful response" do
      get :index
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).not_to be_empty
      expect(response).to have_http_status(:success)
      expect(parsed_response.length).to eq(1)
      puts "\n#{parsed_response}\n"
    end
  end

  describe "GET #show" do
    it "returns successful response with filled order items" do
      get :show, params: { id: user.id }
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).not_to be_empty
      expect(parsed_response.length).to eq(1)
      expect(response).to have_http_status(:success)
      puts "\nOrder history of user id #{user.id}\n#{parsed_response}\n"
    end
    let!(:demo_user) { create(:user, city: city) }
    it "returns user order history is empty with an error message" do
      get :show, params: { id: demo_user.id }
      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(:not_found)
      puts parsed_response
    end
    it "returns user not exists with an error message" do
      get :show, params: { id: 100 }
      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(:not_found)
      puts parsed_response
    end
  end

  describe "GET #make_order" do
    # Test data for making user cart and testing make_order
    let!(:user1) { create(:user, city: city) }
    let!(:cart) { Cart.find_by(user_id: user1.id) }
    let!(:menu1) { FactoryBot.create(:menu, item_name: "Bira White", item_type: "Beverage", restaurant_detail: restaurant_detail, available: true) }
    let!(:cart_item) { create(:cart_item, qty: 2, menu: menu1, cart: cart) }

    it "returns successful response" do
      cart_items = cart.cart_items
      cart_gross_amount = cart_items.map { |c| c["price"] }.sum
      get :make_order, params: { id: user1.id }
      parsed_response = JSON.parse(response.body)
      orders = Order.find_by(user_id: user1.id)
      puts "\n#{parsed_response}\nOrder Details of user #{user1.id}\n"
      puts "#{orders.order_items.to_json}"
      order_gross_amount = orders.order_items.map { |o| o["total_price"] }.sum
      expect(cart_gross_amount).to eq(order_gross_amount)
    end

    let!(:user2) { create(:user, city: city) }
    it "returns user cart is empty with an error message" do
      get :make_order, params: { id: user2.id }
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).not_to be_empty
      expect(response).to have_http_status(:unprocessable_entity)
      puts "\nError : \n#{parsed_response}\n"
    end
    it "returns user not found with an error message" do
      get :make_order, params: { id: 100 }
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).not_to be_empty
      expect(response).to have_http_status(:not_found)
      puts "\nError : \n#{parsed_response}\n"
    end
  end
end

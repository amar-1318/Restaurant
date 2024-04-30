require "rails_helper"

RSpec.describe RatingController, type: :controller do
  let!(:city) { create(:city) }
  let!(:user) { create(:user, city: city) }
  let!(:order) { create(:order, user: user) }
  let!(:restaurant_detail) { create(:restaurant_detail, city: city) }
  let!(:menu1) { create(:menu, item_name: "Ice-cream", item_type: "Desert", restaurant_detail: restaurant_detail, price: 80, available: true) }
  let!(:order_item1) { create(:order_item, order: order, menu_id: menu1.id, item_name: "Ice-cream", item_type: "Desert", qty: 2, total_price: 180) }
  let!(:rating) { create(:rating, user: user, order_item_id: order_item1.id, rating: 5, menu_id: menu1.id) }

  describe "GET #index" do
    it "returns successful response" do
      get :index
      puts response.body
      expect(response).to have_http_status(:success)
      expect(response.body).not_to be_empty
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.length).to eq(1)
    end
  end

  describe "POST #create" do
    let!(:menu2) { create(:menu, item_name: "Kingfisher", item_type: "Beverage", restaurant_detail: restaurant_detail, price: 90, available: true) }
    let!(:order_item2) { create(:order_item, order: order, menu_id: menu2.id, item_name: "Ice-cream", item_type: "Desert", qty: 2, total_price: 180) }

    it "returns successful response with rating details" do
      post :create, params: { order_item_id: order_item2.id, user_id: user.id, rating: 4 }
      puts response.body
      expect(response).to have_http_status(:success)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["user_id"]).to eq(user.id)
      expect(parsed_response["order_item_id"]).to eq(order_item2.id)
      expect(parsed_response["menu_id"]).to eq(menu2.id)
      expect(parsed_response["rating"]).to eq(4)
    end

    it "returns already rated with an error message" do
      post :create, params: { order_item_id: order_item2.id, user_id: user.id, rating: 4 }
      post :create, params: { order_item_id: order_item2.id, user_id: user.id, rating: 4 }
      expect(response).to have_http_status(:unprocessable_entity)
      puts response.body
    end
  end
end

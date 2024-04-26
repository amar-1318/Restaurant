require "rails_helper"

RSpec.describe RestaurantDetailController, type: :controller do
  let!(:city) { FactoryBot::create(:city) }
  let!(:user) { FactoryBot::create(:user) }

  describe "POST #create" do
    it "creates a new restaurant_detail" do
      restaurant_params = FactoryBot.attributes_for(:restaurant_detail, city_id: city.id, user_id: user.id)
      post :create, params: restaurant_params
      puts response.body
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns a successful response" do
      create(:restaurant_detail)
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).not_to be_empty
      puts response.body
    end
  end
end

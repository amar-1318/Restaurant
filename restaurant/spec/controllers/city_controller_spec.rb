require "rails_helper"

RSpec.describe CityController, type: :controller do
  let!(:state) { FactoryBot.create(:state) }
  describe "POST #create" do
    it "creates a new city" do
      post :create, params: { name: "Pune", state_id: state.id, pincode: "413002" }
      puts "Response Body : #{response.body}"
      expect(response).to be_successful
      expect(response).not_to be_empty
    end
  end

  describe "GET #index" do
    it "returns a successful response" do
      FactoryBot::create(:city)
      get :index
      expect(response).to be_successful
      puts "Response body : #{response.body}"
      expect(response).not_to be_empty
    end
  end
end

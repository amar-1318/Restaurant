require "rails_helper"

RSpec.describe StateController, type: :controller do
  describe "POST #create" do
    it "creates a new user" do
      post :create, params: { name: "Maharashtra" }
      expect(response).to be_successful
    end
  end
  describe "GET #index" do
    it "returns a successful response" do
      create(:state)
      get :index
      expect(response).to be_successful
      puts "Response body : #{response.body}"
    end
  end
end

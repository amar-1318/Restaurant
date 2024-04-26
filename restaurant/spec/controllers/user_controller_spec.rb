require "rails_helper"

RSpec.describe UserController, type: :controller do
  let!(:city) { create(:city) }
  let!(:user) { create(:user, city: city) }

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
      puts "Response body : #{response.body}"
    end
  end

  describe "POST #create" do
    it "creates a new user" do
      user_params = FactoryBot.attributes_for(:user, city_id: city.id)
      expect {
        post :create, params: user_params
      }.to change(User, :count).by(1)
      if response.status != 200
        puts "Errors: #{assigns(:user).errors.full_messages}"
      end
      puts response.body
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #login" do
    it "User Login" do
      post :login, params: { email: user.email, password: user.password }
      expect(response).to have_http_status(:success)
    end
  end
end

require "rails_helper"

RSpec.describe UserController, type: :controller do
  let!(:city) { create(:city) }
  let!(:user) { create(:user, city: city) }

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      parsed_response = JSON.parse(response.body)
      expect(response).to be_successful
      expect(parsed_response.length).to eq(1)
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
    it "returns email has already taken" do
      user_params = FactoryBot.attributes_for(:user, city_id: city.id)
      post :create, params: user_params
      if response.status != 200
        puts "Errors: #{assigns(:user).errors.full_messages}"
      end
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "POST #login" do
    it "returns successful response" do
      post :login, params: { email: user.email, password: user.password }
      expect(response).to have_http_status(:success)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["email"]).to eq(user.email)
    end
    it "returns user invalid response" do
      post :login, params: { email: "demo@13.com", password: user.password }
      expect(response).to have_http_status(:unauthorized)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["errors"]).to eq("Bad credentials!")
    end
  end
end

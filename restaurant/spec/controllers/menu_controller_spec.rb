require "rails_helper"

RSpec.describe MenuController, type: :controller do
  let!(:city) { create(:city) }
  let!(:restaurant_detail) { create(:restaurant_detail, city: city) }
  let!(:menu1) { create(:menu, item_name: "Ice-cream", item_type: "Desert", restaurant_detail: restaurant_detail, available: true) }
  let!(:menu2) { create(:menu, item_name: "Burger", item_type: "Beverage", restaurant_detail: restaurant_detail, available: true) }
  let!(:menu3) { create(:menu, item_name: "Panner angara", item_type: "main_course", restaurant_detail: restaurant_detail, available: true) }
  let!(:menu4) { create(:menu, item_name: "Pasta", item_type: "Beverage", restaurant_detail: restaurant_detail, available: true) }
  let!(:menu5) { create(:menu, item_name: "Tuborg", item_type: "Beverage", restaurant_detail: restaurant_detail, available: true) }
  let!(:menu6) { create(:menu, item_name: "Budwiser", item_type: "Beverage", restaurant_detail: restaurant_detail, available: false) }

  let!(:menu_params) {
    {
      item_name: "Bira White",
      item_type: "Beverage",
      price: 190,
      stock: 30,
      rating: 3,
      available: false,
    }
  }

  describe "POST #create" do
    it "returns a successful response" do
      post :create, params: menu_params.merge(restaurant_detail_id: restaurant_detail.id)
      parsed_response = JSON.parse(response.body)
      puts parsed_response
      expect(parsed_response).not_to be_empty
      expect(parsed_response["restaurant_detail_id"]).to eq(restaurant_detail.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns all availble menus" do
      get :index
      puts "\n\n"
      parsed_response = JSON.parse(response.body)
      puts "All menu \n#{parsed_response}"
      expect(parsed_response).not_to be_empty
      expect(parsed_response.length).to eq(5)
    end
  end

  describe "GET #display_city_menu" do
    it "returns a successful response" do
      puts "\n\nMenu from city #{city.name}\n\n"
      get :display_city_menu, params: { city_id: city.id }
      parsed_response = JSON.parse(response.body)
      puts parsed_response
      expect(parsed_response).not_to be_empty
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      puts "\n\nMenu of id #{menu1.id}\n\n"
      get :show, params: { id: menu1.id }
      parsed_response = JSON.parse(response.body)
      puts parsed_response
      expect(parsed_response).not_to be_empty
      expect(parsed_response["available"]).to eq(true)
    end
  end

  describe "GET #search_by_menu_name" do
    context "when menu items matching the name are found" do
      it "returns a successful response" do
        get :search_by_menu_name, params: { item_name: "Pasta", city: city }
        parsed_response = JSON.parse(response.body)
        puts "\n\nSearch by item name\n"
        puts parsed_response
        parsed_response.each do |menu|
          expect(menu["available"]).to eq(true)
        end
        expect(parsed_response).not_to be_empty
        expect(response).to have_http_status(:success)
      end
    end
    context "when there is no matching menu items are found" do
      it "returns a not found error" do
        get :search_by_menu_name, params: { item_name: "Chicken", city: city }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ "errors" => "Record not found!!" })
      end
    end
  end

  describe "GET #display_menu_of_item_type" do
    context "when requesting menus of a specific item type" do
      it "returns a successful response containing menu of specified menu type" do
        get :display_menu_of_item_type, params: { item_type: "Beverage", city_id: city }
        parsed_response = JSON.parse(response.body)
        puts "\n\nDisplay menu of item type Beverage\n"
        puts parsed_response
        expect(parsed_response).not_to be_empty
        expect(parsed_response.length).to eq(3)
        expect(response).to have_http_status(:success)
      end
    end
  end
end

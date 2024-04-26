class RestaurantDetailController < ApplicationController
  def index
    @restaurant = RestaurantDetail.all
    render json: @restaurant, each_serializer: RestaurantSerializer, status: :ok
  end

  def create
    @restaurant = RestaurantDetail.create(rest_params)
    if @restaurant.valid?
      render json: @restaurant, each_serializer: RestaurantSerializer, status: :ok
    else
      render json: { errors: @restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def view_restaurants
    @restaurant = RestaurantDetail.where(city_id: params[:city])
    if @restaurant.present?
      render json: @restaurant, each_serializer: RestaurantSerializer, status: :ok
    else
      render json: { errors: "Restaurant Not Found" }, status: :not_found
    end
  end

  def show
    @restaurant = RestaurantDetail.find_by(id: params[:id])
    if @restaurant
      render json: @restaurant, each_serializer: RestaurantSerializer, status: :ok
    else
      render json: { errors: "Restaurant Not Found" }, status: :not_found
    end
  end

  def max_avg_rating
    restaurant = RestaurantDetail.new
    render json: restaurant.max_avg_rating, status: :ok
  end

  def find
    name = RestaurantDetail.arel_table[:name]
    @restaurants = RestaurantDetail.where(name.matches("%#{params[:name]}%")).where(city_id: params[:city])
    if @restaurants.present?
      render json: @restaurants, each_serializer: RestaurantSerializer, status: :ok
    else
      render json: { errors: "Record Not Found" }, status: :not_found
    end
  end

  # def ordered_count
  #   restaurant_menus = Menu.where(restaurant_detail_id:params[:id])
  #   menus = restaurant_menus.ids
  #   order_items = OrderItem.group(:menu_id)
  #   result = menus.all.collect do |val|
  #     order_items.where(menu_id:val).count
  #   end
  # end

  private

  def rest_params
    params.permit(:name, :address, :description, :user_id, :city_id)
  end
end

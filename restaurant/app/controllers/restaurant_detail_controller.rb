
class RestaurantDetailController < ApplicationController
  def index
   @restaurant =  RestaurantDetail.all
   render json: @restaurant, each_serializer: RestaurantSerializer
  end

  def create  
    @restaurant = RestaurantDetail.create(rest_params)
    if @restaurant.valid?
      render json: @restaurant, each_serializer: RestaurantSerializer
    else
      render json: {errors: @restaurant.errors.full_messages}
    end
  end
  
  def view_restaurants
    @restaurant = RestaurantDetail.where(city_id:params[:city])
    render json: @restaurant, each_serializer: RestaurantSerializer
  end

  def show
    if restaurant = RestaurantDetail.find_by(id:params[:id])
      render json: restaurant, each_serializer: RestaurantSerializer
    else
      render json: {errors: "Restaurant Not Found"}
    end
  end

  def max_avg_rating
    restaurant = RestaurantDetail.new
    render json: restaurant.max_avg_rating
  end

  def find
    name = RestaurantDetail.arel_table[:name];
    @restaurants = RestaurantDetail.where(name.matches("%#{params[:name]}%")).where(city_id:params[:city])
    render json: @restaurants, each_serializer: RestaurantSerializer
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
    params.permit(:name,:address,:description,:user_id, :city_id)
  end
end

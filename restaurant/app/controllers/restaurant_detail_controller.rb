
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

  def show
    if rest = RestaurantDetail.find_by(id:params[:id])
      render json: rest, each_serializer: RestaurantSerializer
    else
      render json: {errors: "Restaurant Not Found"}
    end
  end

  def max_avg_rating
    restaurant = RestaurantDetail.new
    render json: restaurant.max_avg_rating
  end

  private 
  def rest_params
    params.permit(:name,:address,:description,:user_id, :city_id)
  end
end

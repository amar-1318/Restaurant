class CityController < ApplicationController
  def index
    @city =  City.all
    render json: @city.as_json(except: [:created_at, :updated_at])
  end

  def show
    if @city = City.find_by(id:params[:id])
      render json: @city.as_json(except: [:created_at, :updated_at])
    else
      render json: {error: "City not found!"}
    end
  end

  def create
    @city = City.create(city_params)
    if @city.valid?
      render json:@city.as_json(except: [:created_at, :updated_at])
    else
      render json: {error: @city.errors.full_messages}
    end
  end

  private
  def city_params
    params.permit(:name, :state_id, :pincode)
  end
end

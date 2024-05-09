class CitiesController < ApplicationController
  def index
    @city = City.all
    render json: @city.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  def show
    @city = City.find_by(id: params[:id])
    render json: @city&.as_json(except: [:created_at, :updated_at]) || { error: "City not found!" }, status: @city ? :ok : :not_found
  end

  def create
    @city = City.create(city_params)
    if @city.valid?
      render json: @city.as_json(except: [:created_at, :updated_at]), status: :ok
    else
      render json: { error: @city.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def city_params
    params.permit(:name, :state_id, :pincode)
  end
end

require "pry"

class StateController < ApplicationController
  def index
    @state = State.all
    render json: @state.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  def show
    @state = State.find_by(id: params[:id])
    render json: @state&.as_json(except: [:created_at, :updated_at]) || { error: "State not found!" }, status: @state ? :ok : :not_found
  end

  def create
    @state = State.create(state_params)
    if @state.valid?
      render json: @state.as_json(except: [:created_at, :updated_at]), status: :ok
    else
      render json: { error: @state.errors.full_messages }, status: :not_found
    end
    # binding.pry
  end

  private

  def state_params
    params.permit(:name)
  end
end

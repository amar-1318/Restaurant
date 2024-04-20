require "pry"

class StateController < ApplicationController
  def index
    @state =  State.all
    render json: @state.as_json(except: [:created_at, :updated_at])
  end

  def show
    if @state = State.find_by(id:params[:id])
      render json: @state.as_json(except: [:created_at, :updated_at])
    else
      render json: {error: "State not found!"}
    end
  end
  
  def create
    @state = State.create(state_params)
    if @state.valid?
      render json:@state.as_json(except: [:created_at, :updated_at])
    else
      render json: {error: @state.errors.full_messages}
    end
    binding.pry
  end

  private
  def state_params
    params.permit(:name)
  end

end

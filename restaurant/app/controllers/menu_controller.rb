class MenuController < ApplicationController
  def index
    @menu = Menu.all
    render json: @menu, each_serializer: MenuSerializer 
  end

  def create
    menu = Menu.create(menu_params)
    if menu.valid?
      render json: menu , each_serializer: MenuSerializer 
    else
      render json: {errors: menu.errors.full_messages}
    end
  end

  def show 
    if menu = Menu.find_by(id:params[:id])
      render json: menu , each_serializer: MenuSerializer
    else
      render json: {errors: "Record Not Found!!"}
    end
  end

  def display_types
    @types = Menu.pluck(:item_type)
    render json: @types
  end


  private 
  def menu_params
    params.permit(:item_name,:item_type,:price,:restaurant_detail_id,:stock,:rating,:available)
  end
end

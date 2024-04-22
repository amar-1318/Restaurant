class MenuController < ApplicationController
  def index
    @menu = Menu.joins(:restaurant_detail).where(restaurant_detail:{city_id:params[:city]})
    render json: @menu, each_serializer: MenuSerializer 
  end

  def create
    menu = Menu.create(menu_params)
    if menu.valid?
      render json: menu , each_serializer: MenuSerializer 
    else
      render json: { errors: menu.errors.full_messages }
    end
  end

  def show 
    if menu = Menu.find_by(id:params[:id])
      render json: menu , each_serializer: MenuSerializer
    else
      render json: {errors: "Record Not Found!!"}
    end
  end
  
  def update
    @menu = Menu.find_by(id:params[:id])
    if (@menu!=nil) && (@menu.update(menu_params))
      render json: [Menu: @menu.as_json(except: [:created_at, :updated_at]), message: "Menu Successfully updated!"]
    else  
      render json: {errors: @menu.errors.full_messages}      
    end
  end

  def display_restaunt_menu
    menus = Menu.where(restaurant_detail_id:params[:id])
    if menus.size!=0
      render json: menus , each_serializer: MenuSerializer
    else
      render json: {errors: "Menu is empty!!"}    
      return
    end
  end

  def display_types
    @types = Menu.pluck(:item_type)
    render json: @types
  end

  def search_by_menu_name
    item_name = Menu.arel_table[:item_name]
    @menu = Menu.joins(:restaurant_detail).where(item_name.matches("%#{params[:item_name]}%")).where(restaurant_detail: { city_id: params[:city] })
    render json: @menu , each_serializer: MenuSerializer
  end

  private 
  def menu_params
    params.permit(:item_name,:item_type,:price,:restaurant_detail_id,:stock,:rating,:available)
  end
end

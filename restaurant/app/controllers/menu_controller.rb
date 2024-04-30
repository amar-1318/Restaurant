class MenuController < ApplicationController
  def index
    @menus = Menu.where(available: true)
    render json: @menus, each_serializer: MenuSerializer, status: :ok
  end

  def display_city_menu
    @menu = Menu.joins(:restaurant_detail).where(restaurant_detail: { city_id: params[:city_id] })
    if @menu.present?
      render json: @menu, each_serializer: MenuSerializer, status: :ok
    else
      render json: { error: "Menu not found!" }, status: :not_found
    end
  end

  def create
    menu = Menu.create(menu_params)
    if menu.valid?
      render json: menu, each_serializer: MenuSerializer, status: :ok
    else
      render json: { errors: menu.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    if menu = Menu.find_by(id: params[:id])
      render json: menu, each_serializer: MenuSerializer, status: :ok
    else
      render json: { errors: "Record Not Found!!" }, status: :not_found
    end
  end

  def update
    @menu = Menu.find_by(id: params[:id])
    if (@menu.present?) && (@menu.update(menu_params))
      render json: [Menu: @menu.as_json(except: [:created_at, :updated_at]), message: "Menu Successfully updated!"], status: :ok
    else
      render json: { errors: "Something went wrong" }, status: :unprocessable_entity
    end
  end

  def display_restaunt_menu
    @menus = Menu.where(restaurant_detail_id: params[:id]).where(available: true)
    if @menus.present?
      render json: @menus, each_serializer: MenuSerializer, status: :ok
    else
      render json: { errors: "Menu is empty!!" }, status: :not_found
      return
    end
  end

  def display_menu_of_item_type
    @menus = Menu.joins(:restaurant_detail).where(item_type: params[:item_type]).where(restaurant_detail: { city_id: params[:city_id] }).where(available: true)
    if @menus.present?
      render "display_menu_of_item_type"
    else
      @error_message = { errors: "Record not found!!" }
    end
  end

  def display_types
    @types = Menu.pluck(:item_type).uniq
    render json: @types, status: :ok
  end

  def search_by_menu_name
    item_name = Menu.arel_table[:item_name]
    @menu = Menu.joins(:restaurant_detail).where(item_name.matches("%#{params[:item_name]}%")).where(restaurant_detail: { city_id: params[:city] })
    if @menu.present?
      render json: @menu, each_serializer: MenuSerializer, status: :ok
    else
      render json: { errors: "Record not found!!" }, status: :not_found
    end
  end

  private

  def menu_params
    params.permit(:item_name, :item_type, :price, :restaurant_detail_id, :stock, :rating, :available)
  end
end

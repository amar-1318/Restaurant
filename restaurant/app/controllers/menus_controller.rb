class MenusController < ApplicationController
  def index
    @menus = Menu.where(available: true)
    render json: @menus, status: :ok
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
    menu = Menu.new(menu_params)
    if menu.save
      flash[:notice] = "Menu successfully created."
      redirect_to owner_dashboard_users_path
    else
      flash[:alert] = "Failed to add menu: #{menu.errors.full_messages.join(", ")}"
      render :new
    end
  end

  def new
    @restaurant = current_user.restaurant_detail
  end

  def show
    @menu = Menu.find_by(id: params[:id])
  end

  def update
    @menu = Menu.find_by(id: params[:id])
    if (@menu.present?) && (@menu.update(menu_params))
      redirect_to owner_dashboard_users_path
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

  def item_type_menu
    @menus = Menu.joins(:restaurant_detail).where(item_type: params[:item_type]).where(restaurant_detail: { city_id: params[:city_id] }).where(available: true)
    if @menus.present?
      render :item_type_menu
    else
      @error_message = { errors: "Record not found!!" }
    end
  end

  def display_types
    @types = Menu.pluck(:item_type).uniq
    render json: @types, status: :ok
  end

  def search
    item_name = Menu.arel_table[:item_name]
    @menu = Menu.joins(:restaurant_detail).where(item_name.matches("%#{params[:item_name]}%")).where(restaurant_detail: { city_id: params[:city] })
    if @menu.present?
      render json: @menu
    else
      render json: { errors: "Record not found!!" }, status: :not_found
    end
  end

  private

  def menu_params
    params.permit(:item_name, :item_type, :price, :restaurant_detail_id, :stock, :rating, :available)
  end
end

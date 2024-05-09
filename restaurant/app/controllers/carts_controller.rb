class CartsController < ApplicationController
  def index
    @cart = Cart.all
    render json: @cart, status: :ok
  end

  def create
    @cart = Cart.create(cart_params)
    if @cart.valid?
      render json: @cart, each_serializer: CartSerializer, status: :ok
    else
      render json: { error: "Something went wrong" }, status: 500
    end
  end

  def show
    @user = User.find(params[:id])
    @cart = Cart.find_by(user_id: params[:id])
    if @cart.nil?
      render json: { error: "User cart not found!!" }, status: :not_found
      return
    end
    @cart_items = @cart.cart_items
    if @cart_items.empty?
      @error_message = { empty: "User cart is empty!!" }
      return
    end
    @total_price = @cart_items.sum(:price)
  end

  def add_cart_items
    #============== User and menu city validation =====================
    begin
      menu = Menu.find(params[:menu_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Menu not found" }, status: :not_found
      return
    end
    if menu.restaurant_detail.city_id != User.find(params[:id]).city_id
      render json: { error: "You can select items from your regions only!" }
      return
    end
    #============== Restaurant conflict validation =====================
    cart_id = Cart.find_by(user_id: params[:id]).id
    @cart_item = CartItem.find_by(cart_id: cart_id)
    if @cart_item.present?
      @restaurant_id_1 = Menu.find(@cart_item.menu_id).restaurant_detail_id
      @restaurant_id_2 = Menu.find(params[:menu_id]).restaurant_detail_id
      if @restaurant_id_1 != @restaurant_id_2
        render json: { error: "You can select items from one restaurant only" }, status: :forbidden
        return
      end
    end
    #============== Create cart items =====================
    cart = CartItem.create(cart_id: cart_id, menu_id: params[:menu_id].to_i, qty: params[:qty].to_i, price: Menu.find(params[:menu_id]).price.to_i * params[:qty].to_i)
    if cart.valid?
      render json: cart.as_json(except: [:created_at, :updated_at]), status: :ok
      return
    else
      render json: { error: cart.errors.full_messages }, status: :unprocessable_entity
      return
    end
  end

  def pending_cart_worth_1000
    @cart = User.joins(cart: :cart_items).group(:user_id, :name).having("SUM(cart_items.price) >
    ?", 1000).pluck(:user_id, :name, "SUM(cart_items.price)")
    @result = []
    @cart.each { |a, b, c| @result.push(["ID : #{a}", "Name : #{b}", "Total : #{c}"]) }
    render json: @result, status: :ok
  end

  def delete
    @item = CartItem.find_by(id: params[:item_id])
    if @item.present?
      menu = Menu.find(@item.menu_id)
      menu.update(stock: menu.stock + @item.qty)
      @item.delete
      render json: { success: "Item #{params[:item_id]} deleted from cart" }, status: 204
    else
      render json: { error: "Invalid item id" }, status: :forbidden
    end
  end

  def update
    @item = CartItem.find_by(id: params[:item_id])
    if !@item.present?
      render json: { error: "Invalid cart item id!!" }, status: :unprocessable_entity
      return
    end
    if (params[:qty]).to_i == 0
      @item.delete
      render json: { deleted: "Item deleted from cart!" }
    elsif @item.update(qty: (params[:qty]).to_i)
      @item.update(price: Menu.find(@item.menu_id).price * params[:qty].to_i)
      render json: { success: "Quantity successfully updated to #{params[:qty]}" }, status: :ok
    else
      render json: { error: "Quantity must be in between 1..20" }, status: :unprocessable_entity
    end
  end

  private

  def cart_params
    params.permit(:user_cart)
  end
end

class CartController < ApplicationController
  def index
    @cart = Cart.all
    render json: @cart, each_serializer: CartSerializer
  end

  def create
    @cart = Cart.create(cart_params)
    if @cart.valid?
      render json: @cart, each_serializer: CartSerializer 
    else
      render json: {error: "Something went wrong"}
    end
  end

  def show 
    if !Cart.exists?(user_id:params[:id])
      render json: {error: "User cart not found!!"}
      return  
    end
    @cart_items = Cart.find_by(user_id:params[:id]).cart_items
    if @cart_items.empty?
      render json: {error: "User cart is empty"}
      return
    end
    render json: @cart_items, each_serializer: CartitemSerializer
  end

  def add_cart_items
    cart_id = Cart.find_by(user_id:params[:id])

    if !cart_id.valid?
      cart_id = Cart.create(user_id:params[:id])
    end

    cart = CartItem.create(cart_id:cart_id.id, menu_id:params[:menu_id], qty:params[:qty], price:Menu.find(params[:menu_id]).price * params[:qty])
    if cart.valid? 
      render json: cart.as_json(except: [:created_at, :updated_at])
    else
      render json: {error: cart.errors.full_messages}
    end
  end

  def pending_cart_worth_1000
    @cart = User.joins(cart: :cart_items).group(:user_id,:name).having('SUM(cart_items.price) >
    ?',1000).pluck(:user_id,:name,'SUM(cart_items.price)')
    @result = []
    @cart.each{|a,b,c| @result.push(["ID : #{a}" ,"Name : #{b}", "Total : #{c}"])}
    render json: @result
  end

  private 
  def cart_params
    params.permit(:user_cart)
  end

end

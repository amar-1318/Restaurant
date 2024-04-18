class CartController < ApplicationController
  def index
    @cart = Cart.all
    render json: @cart, each_serializer: CartSerializer
  end

  def create
    cart = Cart.create(cart_params)
    if cart.valid?
      render json: cart, each_serializer: CartSerializer 
    else
      render json: {error: "Something went wrong"}
    end
  end

  def show 
    render json: Cart.find_by(user_id:params[:id]).cart_items
  end

  def add_cart_items
      params[:id]
  end

  private 
  def cart_params
    params.permit(:user_cart)
  end

end

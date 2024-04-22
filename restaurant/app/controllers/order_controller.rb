class OrderController < ApplicationController
  def index
    @order = Order.all
    render json: @order, each_serializer: OrderSerializer
  end

  def show
    if !User.exists?(params[:id])
      render json: {error: "User not exists!!"}
      return 
    end
    @user_order = Order.where(user_id:params[:id])
    if @user_order.empty?
      render json: {error: "No orders yet!!"}
      return
    end
    @order = @user_order.collect do |o| [Items: o.OrderItems,Gross_Amount:o.gross_amount] end
    render json: {User_Orders: @order.as_json(except: [:created_at, :updated_at]) } 
  end

  def max_qty_ordered_food
    render json: OrderItem.select("id, item_name, qty, to_char(created_at, 'Month, DD, YYYY')").limit(10).order(qty: :desc)
  end

  def recent_orders
    order = OrderItem.new
    render json: order.recent_orders, each_serializer: OrderitemSerializer
  end

  def make_order
    ActiveRecord::Base.transaction do
      if !user_cart = Cart.find_by(user_id:params[:id])
        render json: {errors: "User not found"}
        return
      end
      if !CartItem.exists?(cart_id:user_cart.id)
        render json: {errors: "Cart is empty.. Cannot place an order!"}
        return
      end
      if cart = user_cart.cart_items
        total_price = user_cart.cart_items.sum(:price)
        order = Order.create(user_id:params[:id], gross_amount:total_price,status:"SUCCESS")
        cart.each_with_index do |key,idx|
          OrderItem.create(order_id:order.id,menu_id:cart[idx]["menu_id"],item_name:Menu.find(cart[idx]["menu_id"]).item_name,item_type:Menu.find(cart[idx]["menu_id"]).item_type,qty:cart[idx]["qty"],total_price:cart[idx]["price"])
        end
        CartItem.delete_by(cart_id: user_cart.id)
        render json: {success: "Successfully ordered!!"}
      else
        render json: {errors: cart.errors.full_messages}
      end
    end
  end

end

class OrderController < ApplicationController
  def index
    @order = Order.all
    render json: @order, each_serializer: OrderSerializer, status: :ok
  end

  def show
    if !User.exists?(params[:id])
      render json: { error: "User not exists!!" }, status: :not_found
      return
    end
    @user_order = Order.where(user_id: params[:id])
    if @user_order.empty?
      render json: { error: "No orders yet!!" }, status: :not_found
      return
    end
    @order = @user_order.collect do |o| [Items: o.OrderItems, Gross_Amount: o.gross_amount] end
    render json: { User_Orders: @order.as_json(except: [:created_at, :updated_at]) }, status: :ok
  end

  def max_qty_ordered_food
    render json: OrderItem.select("id, item_name, qty, to_char(created_at, 'Month, DD, YYYY')").limit(10).order(qty: :desc), status: :ok
  end

  def recent_orders
    order = OrderItem.new
    render json: order.recent_orders, each_serializer: OrderitemSerializer, status: :ok
  end

  def make_order
    ActiveRecord::Base.transaction do
      if !user_cart = Cart.find_by(user_id: params[:id])
        render json: { errors: "User not found" }, status: :not_found
        return
      end
      if !CartItem.exists?(cart_id: user_cart.id)
        render json: { errors: "Cart is empty.. Cannot place an order!" }, status: :unprocessable_entity
        return
      end
      if cart_item = user_cart.cart_items
        total_price = user_cart.cart_items.sum(:price)
        order = Order.create(user_id: params[:id], gross_amount: total_price, status: "SUCCESS", restaurant_details_id: Menu.find(cart_item[0]["menu_id"]).restaurant_detail_id)
        cart_item.each_with_index do |key, idx|
          OrderItem.create(order_id: order.id, menu_id: cart_item[idx]["menu_id"], item_name: Menu.find(cart_item[idx]["menu_id"]).item_name, item_type: Menu.find(cart_item[idx]["menu_id"]).item_type, qty: cart_item[idx]["qty"], total_price: cart_item[idx]["price"])
        end
        CartItem.delete_by(cart_id: user_cart.id)
        render json: { success: "Successfully ordered!!" }, status: :ok
      else
        render json: { errors: cart_item.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end

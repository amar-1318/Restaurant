class RatingController < ApplicationController
  def index
    @rating = Rating.all
    render json:@rating.as_json(except: [:created_at, :updated_at])
  end

  def create
    menu_id = OrderItem.find(rating_params[:order_item_id]).menu_id;
    # if Order.find_by(user_id:rating_params[:user_id]).id != OrderItem.find_by(id:rating_params[:order_item_id]).order_id   
    #   render json:{errors: "You can rate for your orders only"}
    #   return 
    # end
    @rating = Rating.create(order_item_id:rating_params[:order_item_id],menu_id:menu_id,user_id:rating_params[:user_id],rating:rating_params[:rating])
    if @rating.valid?
      render json:@rating.as_json(except: [:created_at, :updated_at])
    else
      render json:{ errors: @rating.errors.full_messages }
    end
  end

  def show
  end

  private
  def rating_params
    params.permit(:order_item_id,:user_id,:rating)
  end

end

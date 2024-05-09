class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
    @states = State.all
    @cities = City.all
  end

  def create
    puts "Hello"
    puts user_params
    @user = User.create(user_params)
    if @user.valid?
      if @user.role == "CUSTOMER"
        redirect_to customer_dashboard_path(@user)
      elsif @user.role == "ADMIN"
        redirect_to admn_dashboard_path
      else
        redirect_to "owner_dashboard"
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def get_login
    render "login"
  end

  def login
    @user = User.find_by(email: user_signin_params["email"], password: user_signin_params["password"])
    if @user.present?
      if @user.role == "CUSTOMER"
        redirect_to customer_dashboard_path(@user)
      elsif @user.role == "ADMIN"
        redirect_to admn_dashboard_path
      else
        redirect_to owner_dashboard_path
      end
    else
      @error_message = { error: "Bad credentials!" }
    end
    puts "Errors"
    puts @error_message
  end

  def update
    @user = User.find_by(id: params[:id])
    if (@user.present?) && (@user.update(user_params))
      render json: { User: @user.as_json(except: [:created_at, :updated_at]), message: "Successfully Updated!" }, status: :ok
    else
      render json: { error: "User not found!!" }, status: :not_found
    end
  end

  def customer_dashboard
    @user = User.find(current_user.id)
    @city = @user.city
    @restaurants = RestaurantDetail.where(city_id: @city.id)
  end

  def owner_dashboard
    start_of_week = Date.today.beginning_of_week
    end_of_week = Date.today.end_of_week

    start_of_month = Date.today.beginning_of_month
    end_of_month = Date.today.end_of_month

    start_of_year = Date.today.beginning_of_year
    end_of_year = Date.today.end_of_year

    @weekly_analysis = Order.where(restaurant_details_id: current_user.restaurant_detail.id).where(created_at: start_of_week..end_of_week).sum(:gross_amount)
    @monthly_analysis = Order.where(restaurant_details_id: current_user.restaurant_detail.id).where(created_at: start_of_month..end_of_month).sum(:gross_amount)
    @today_analysis = Order.where(restaurant_details_id: current_user.restaurant_detail.id).where(created_at: Date.today.beginning_of_day..Date.today.end_of_day).sum(:gross_amount)
    @yearly_analysis = Order.where(restaurant_details_id: current_user.restaurant_detail.id).where(created_at: start_of_year..end_of_year).sum(:gross_amount)

    @user = User.find(current_user.id)
    @city = @user.city
    @restaurant = current_user.restaurant_detail
    @menus = @restaurant.menus
    # @menus = User.find(current_user.id).restaurant_detail.menus
  end

  private

  def user_params
    params.permit(:id, :name, :address, :contact, :role, :email, :password, :city_id, :gender)
  end

  def user_signin_params
    params.permit(:email, :password)
  end
end

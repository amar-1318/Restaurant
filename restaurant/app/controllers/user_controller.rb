class UserController < ApplicationController
  def index
    @users = User.all
    render "index"
  end

  def new
    @user = User.new
    @states = State.all
    @cities = City.all
    render "new"
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
    render "show"
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

  private

  def user_params
    params.permit(:id, :name, :address, :contact, :role, :email, :password, :city_id, :gender)
  end

  def user_signin_params
    params.permit(:email, :password)
  end
end

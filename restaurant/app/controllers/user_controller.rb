class UserController < ApplicationController
  def index
    @users = User.all
    render json: @users, each_serializer: UserSerializer
  end

  def create
    @user = User.create(user_signup_params)
    if @user.valid?
      render json: @user, each_serializer: UserSerializer
    else
      render json: {errors: @user.errors.full_messages}
    end
  end

  def login
    @user = user_signin_params
    if user = User.find_by(email:@user["email"], password:@user["password"])
      render json: user, each_serializer: UserSerializer
    else
      render json: "Bad credentials!"
    end
  end

  def update_user
    
  end

  private
  def user_signup_params
    params.permit(:id,:name, :address, :contact, :role, :email, :password)
  end

  def user_signin_params
    params.permit(:email, :password)
  end
end

class UserController < ApplicationController
  def index
    @users = User.all
    render json: @users, each_serializer: UserSerializer
  end

  def create
    @user = User.create(user_params)
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
      render json: {errors: "Bad credentials!"}
    end
  end

  def update
    @user = User.find_by(id:params[:id])
    if (@user!=nil) && (@user.update(user_params))
      render json:{User:@user.as_json(except: [:created_at, :updated_at]), message:"Successfully Updated!"}
    else
      render json: {error:"User not found!! "}
    end
  end

  private
  def user_params
    params.permit(:id,:name, :address, :contact, :role, :email, :password, :city_id)
  end

  def user_signin_params
    params.permit(:email, :password)
  end
end

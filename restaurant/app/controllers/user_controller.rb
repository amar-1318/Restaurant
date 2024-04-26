class UserController < ApplicationController
  def index
    @users = User.all
    render json: @users, each_serializer: UserSerializer, status: :ok
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      render json: @user, each_serializer: UserSerializer, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(email: user_signin_params["email"], password: user_signin_params["password"])
    if @user.present?
      render json: @user, each_serializer: UserSerializer, status: :ok
    else
      render json: { errors: "Bad credentials!" }, status: :unauthorized
    end
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
    params.permit(:id, :name, :address, :contact, :role, :email, :password, :city_id)
  end

  def user_signin_params
    params.permit(:email, :password)
  end
end

class DashboardController < ApplicationController
  def customer_dashboard
    @user = User.find params[:id]
    @city = @user.city
    @restaurants = RestaurantDetail.where(city_id: @city.id)
    render "customer_dashboard"
  end

  def admin_dashboard
    render "admin_dashboard"
  end

  def owner_dashboard
    render "owner_dashboard"
  end

  def about
    render "about"
  end
end

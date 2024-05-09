class Admin::AdminsController < ApplicationController
  def index
    @users = User.all
    start_of_week = Date.today.beginning_of_week
    end_of_week = Date.today.end_of_week
    start_of_month = Date.today.beginning_of_month
    end_of_month = Date.today.end_of_month

    @weekly_analysis = Order.group(:restaurant_details_id).where(created_at: start_of_week..end_of_week).sum(:gross_amount)
    monthly_analysis = Order.where(created_at: start_of_month..end_of_month).group(:restaurant_details_id).sum(:gross_amount)
    today_analysis = Order.group(:restaurant_details_id).where(created_at: Date.today.beginning_of_day..Date.today.end_of_day).sum(:gross_amount)

    @weekly_revenue = @weekly_analysis.values.sum
    @monthly_revenue = monthly_analysis.values.sum
    @daily_revenue = today_analysis.values.sum

    start_of_year = Date.today.beginning_of_year
    end_of_year = Date.today.end_of_year

    @yearly_analysis = Order.where(created_at: start_of_year..end_of_year)
      .group(:restaurant_details_id)
      .sum(:gross_amount)
    @yearly_revenue = @yearly_analysis.values.sum

    @weekly_result = @weekly_analysis.map do |k|
      if k[0] != nil
        { Name: RestaurantDetail.find(k[0]).name, Revenue: k[1] }
      end
    end
    @yearly_result = @yearly_analysis.map do |k|
      if k[0] != nil
        { Name: RestaurantDetail.find(k[0]).name, Revenue: k[1] }
      end
    end
  end

  def customers
    @users = User.paginate(:page => params[:page], :per_page => 5).where(role: "CUSTOMER")
  end

  def owners
    @users = User.paginate(:page => params[:page], :per_page => 5).where(role: "OWNER")
  end

  def restaurants
    @user = User.all
    @restaurants = RestaurantDetail.all
  end

  def daily_revenue
    today_analysis = Order.group(:restaurant_details_id).where(created_at: Date.today.beginning_of_day..Date.today.end_of_day).sum(:gross_amount)
    if today_analysis.present?
      result = today_analysis.map do |k|
        if k[0] != nil
          { Name: RestaurantDetail.find(k[0]).name, Revenue: k[1] }
        end
      end
      if result.present?
        render json: result.compact, status: :ok
      else
        render json: { error: "Record not found" }, status: :not_found
      end
    end
  end

  def weekly_revenue
    start_of_week = Date.today.beginning_of_week
    end_of_week = Date.today.end_of_week
    weekly_analysis = Order.group(:restaurant_details_id).where(created_at: start_of_week..end_of_week).sum(:gross_amount)
    if weekly_analysis.present?
      result = weekly_analysis.map do |k|
        if k[0] != nil
          { Name: RestaurantDetail.find(k[0]).name, Revenue: k[1] }
        end
      end
      if result.present?
        render json: result.compact, status: :ok
      else
        render json: { error: "Record not found" }, status: :not_found
      end
    end
  end
end

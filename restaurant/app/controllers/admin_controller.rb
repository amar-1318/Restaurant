class AdminController < ApplicationController
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

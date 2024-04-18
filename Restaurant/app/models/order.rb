class Order < ApplicationRecord
  has_many :OrderItems
  has_one :payment

  def top_10_ordered_food_in_max_qty
    top_10 = OrderItem.select('item_name, qty').limit(10).order(qty: :desc)
    return top_10;
  end
  

  after_create :log_creation

  private 
  def log_creation
    Rails.logger.info("Order of #{gross_amount}$ successfully created! at #{created_at}")
  end

end

class OrderItem < ApplicationRecord
  belongs_to :order

  scope :recent, -> { where("created_at >= ?", 1.week.ago).order(qty: :desc).limit(10) }

  has_one :rating

  validates :item_name, presence: { message: "cannot be empty" }
  validates :item_type, presence: { message: "cannot be empty" }

  def recent_orders
    return OrderItem.recent
  end
end

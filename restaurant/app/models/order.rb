class Order < ApplicationRecord
  has_many :order_items
  has_one :payment
  belongs_to :user
  after_create :log_creation

  private

  def log_creation
    Rails.logger.info("Order of #{gross_amount}$ successfully created! at #{created_at}")
  end
end

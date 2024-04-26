class Order < ApplicationRecord
  has_many :OrderItems
  has_one :payment
  after_create :log_creation

  private

  def log_creation
    Rails.logger.info("Order of #{gross_amount}$ successfully created! at #{created_at}")
  end
end

class Payment < ApplicationRecord
  belongs_to :order
  
  after_create :log_creation

  private 
  def log_creation
    Rails.logger.info("Payment of #{gross_amount}$ successfully created! at #{created_at}")
  end

end

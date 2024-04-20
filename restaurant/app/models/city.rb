class City < ApplicationRecord
  belongs_to :state
  has_many :users
  has_many :RestaurantDetails

  validates :name, presence: {message:"cannot be empty"}, uniqueness:true
  
  after_create :log_creation
  before_update :log_update
  before_destroy :log_deletion

  private 
  def log_creation
    Rails.logger.info("City #{name} created! at #{created_at}")
  end

  def log_update
    Rails.logger.info("City #{name} updated at #{updated_at}")
  end

  def log_deletion
    Rails.logger.info("City #{name} is deleted")
  end

end

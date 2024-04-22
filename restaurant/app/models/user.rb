class User < ApplicationRecord
  has_one :cart
  has_one :RestaurantDetail
  has_one :city
  has_many :orders
  has_many :ratings
   
  validates :name, presence: {message:"cannot be empty"}
  
  validates :address, presence: {message:"cannot be empty"}
  
  validates :contact, presence: {message:"cannot be empty"},uniqueness:true
  
  validates :email, presence: {message:"cannot be empty"}, uniqueness:true
  
  validates :password, presence: {message:"cannot be empty"}

  after_create :after_create_trigger
  before_update :log_update
  before_destroy :log_deletion

  private
  def after_create_trigger
    Rails.logger.info("User #{name} is created at #{created_at}")
    Cart.create(user_id:id)
  end
  
  def log_update
    Rails.logger.info("User #{name} updated at #{updated_at}. Changes: #{changes}")
  end

  def log_deletion
    Rails.logger.warn("User #{name} deleted..")
  end

end
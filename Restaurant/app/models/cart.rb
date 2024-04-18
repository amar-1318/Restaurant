class Cart < ApplicationRecord
  has_many :cart_items
  belongs_to :user

  validates :user_id , uniqueness: true

  def display_pending_carts_more_than_1000
    cart = User.joins(cart: :cart_items).group(:user_id,:name).having('SUM(cart_items.price) >
    ?',1000).pluck(:user_id,:name,'SUM(cart_items.price)')
    return cart
  end

  after_create :log_creation
  before_update :log_update
  after_destroy :log_deletion

  private 
  def log_creation
    Rails.logger.info("Cart of user #{user_id} created! at #{created_at}")
  end

  def log_update
    Rails.logger.info("Cart of user #{user_id} updated at #{updated_at}")
  end

  def log_deletion
    Rails.logger.info("Cart of user #{user_id} is deleted")
  end

end

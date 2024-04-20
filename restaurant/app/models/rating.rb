class Rating < ApplicationRecord
  # Multiple ratings belongs to one user i.e user can rate multiple items 
  belongs_to :user
  # User can rate only once per order item
  belongs_to :order_item

  validates :rating , numericality: {in: 1..5}
  validates :order_item_id, uniqueness:{message:"Already rated!"}
  after_create :log_creation

  private
  def log_creation
    Rails.logger.info("Rating for menu #{menu_id} is created at #{created_at}")
    menu = Menu.find(menu_id)
    menu.update(rating:(rating+menu.rating)/2)
  end
end


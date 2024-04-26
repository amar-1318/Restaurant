class Rating < ApplicationRecord
  # Multiple ratings belongs to one user i.e user can rate multiple items
  belongs_to :user
  # User can rate only once per order item
  belongs_to :order_item

  validates :rating, numericality: { in: 1..5 }
  validates :order_item_id, uniqueness: { message: "Already rated!" }
  after_create :after_create_trigger

  private

  def after_create_trigger
    ActiveRecord::Base.transaction do
      Rails.logger.info("Rating for menu #{menu_id} is created at #{created_at}")
      menu = Menu.find(menu_id)
      menus = Rating.group(:menu_id).where(menu_id: menu)
      sum_of_rating = menus.sum(:rating).values[0]
      total_user_rated = menus.count.values[0]
      menu.update(rating: ((sum_of_rating) / (total_user_rated)))
    end
  end
end

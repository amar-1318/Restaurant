class Menu < ApplicationRecord

  # Many menus belongs to one restaurant
  belongs_to :restaurant_detail

  # User can order one item with multiple quantities
  has_many :CartItems

  validates :item_name, presence: { message: "cannot be empty" }

  validates :item_type, presence: { message: "cannot be empty" }, inclusion: { in: ["Beverage", "Desert", "main_course"] }

  validates :price, presence: { message: "cannot be empty" }, numericality: { in: 20..1000 }

  validate :unique_menu_and_hotel, on: :create

  after_create :log_creation
  before_create :log_creation
  before_update :log_update

  private

  def log_creation
    Rails.logger.info("Menu named #{item_name}$ successfully created! at #{created_at}")
  end

  def log_update
    Rails.logger.info("Menu #{item_name} updated at #{updated_at}. Changes: #{changes}")
  end

  def unique_menu_and_hotel
    if Menu.exists?(item_name: item_name, restaurant_detail_id: restaurant_detail_id)
      errors.add(:base, "Item named #{item_name} already exists!!")
    end
  end
end

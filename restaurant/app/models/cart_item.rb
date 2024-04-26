class CartItem < ApplicationRecord
  belongs_to :cart

  belongs_to :menu

  after_create :after_create_trigger

  validates :qty, presence: { message: "cannot be empty" }, numericality: { in: 1..20 }

  def display_user_cart
    @user_cart = CartItem.joins(cart: :user).where(user: { id: "1" })
    return @user_cart
  end

  private

  def after_create_trigger
    menu = Menu.find(menu_id)
    if menu.stock > qty
      menu.update(stock: menu.stock - qty)
    else
      raise StandardError, "Insufficient stock"
    end
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error "Menu not found with ID: #{menu_id}"
  rescue StandardError => e
    Rails.logger.error "unexpected error occurred: #{e.message}"
  end
end

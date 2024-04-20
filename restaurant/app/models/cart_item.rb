class CartItem < ApplicationRecord
  belongs_to :cart
  
  belongs_to :menu
  
  validates :qty, presence:{message:"cannot be empty"}, numericality: {in: 1..20}

  def display_user_cart
    @user_cart = CartItem.joins(cart: :user).where(user: {id: "1"})
    return @user_cart
  end
  
end

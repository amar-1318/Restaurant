class OrderItem < ApplicationRecord
  belongs_to :order

  has_one :rating

  validates :item_name,presence:{message:"cannot be empty"}
  
  validates :item_type,presence:{message:"cannot be empty"}

end

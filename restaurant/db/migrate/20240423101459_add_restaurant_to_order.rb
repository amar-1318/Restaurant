class AddRestaurantToOrder < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :restaurant_details, foreign_key:true 
  end
end

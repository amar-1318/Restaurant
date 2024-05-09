class AddRatingToRestaurantDetails < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurant_details, :rating, :float
  end
end

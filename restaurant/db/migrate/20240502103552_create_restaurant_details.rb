class CreateRestaurantDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurant_details do |t|
      t.string :name
      t.string :description
      t.string :address
      t.references :city, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end

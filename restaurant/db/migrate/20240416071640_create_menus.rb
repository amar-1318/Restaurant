class CreateMenus < ActiveRecord::Migration[7.1]
  def change
    create_table :menus do |t|
      t.string :item_name
      t.string :item_type
      t.integer :price
      t.integer :stock
      t.integer :rating
      t.boolean :available
      t.references :restaurant_detail, foreign_key:true
      t.timestamps
    end
  end
end

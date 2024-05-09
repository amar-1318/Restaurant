class CreateOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.references :menu, foreign_key: true
      t.string :item_name
      t.string :item_type
      t.integer :qty
      t.integer :total_price
      t.timestamps
    end
  end
end

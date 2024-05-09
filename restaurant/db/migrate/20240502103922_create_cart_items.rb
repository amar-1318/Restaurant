class CreateCartItems < ActiveRecord::Migration[7.1]
  def change
    create_table :cart_items do |t|
      t.references :cart, foreign_key: true
      t.references :menu, foreign_key: true
      t.integer :qty
      t.integer :price
      t.timestamps
    end
  end
end

class CreateRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :ratings do |t|
      t.references :order_item, foreign_key:true
      t.references :menu, foreign_key:true
      t.references :user, foreign_key:true
      t.integer :rating
      t.timestamps
    end
  end
end

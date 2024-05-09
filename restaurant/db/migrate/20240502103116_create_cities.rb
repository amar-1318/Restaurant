class CreateCities < ActiveRecord::Migration[7.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.references :state, foreign_key: true
      t.string :pincode
      t.timestamps
    end
  end
end

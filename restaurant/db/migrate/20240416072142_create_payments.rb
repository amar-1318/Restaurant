class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :order, foreign_key: true
      t.float :gross_amount
      t.string :status
      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :address
      t.references :city, foreign_key:true
      t.string :contact
      t.string :email
      t.string :password
      t.string :role
      t.timestamps
    end
  end
end

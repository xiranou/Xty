class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street_address
      t.references :city
      t.references :zipcode
      t.timestamps null: false
    end
  end
end

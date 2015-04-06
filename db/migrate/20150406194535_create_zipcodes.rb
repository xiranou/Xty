class CreateZipcodes < ActiveRecord::Migration
  def change
    create_table :zipcodes do |t|
      t.string :zip
      t.references :city
      t.timestamps null: false
    end
  end
end

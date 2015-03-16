class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.references :product
      t.references :buyer
      t.timestamps null: false
    end
  end
end

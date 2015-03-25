class AddQuantityToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :quantities, :integer
  end
end

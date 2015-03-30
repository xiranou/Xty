class AddQuantitiesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :quantities, :integer
  end
end

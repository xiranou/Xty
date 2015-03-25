class AddTransactionIdToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :transaction_id, :string
  end
end

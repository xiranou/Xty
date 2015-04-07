class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.references :user
      t.string :approval_status
      t.string :funding_destination
      t.string :account_number
      t.string :routing_number
      t.date :date_of_birth
      t.timestamps null: false
    end
  end
end

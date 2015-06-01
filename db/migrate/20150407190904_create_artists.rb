class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.references :user
      t.string :approval_status
      t.date :date_of_birth
      t.timestamps null: false
    end
  end
end

class AddBusinessParametersToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :legal_name, :string
    add_column :artists, :tax_id, :string
  end
end

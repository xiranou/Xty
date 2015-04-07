class AddUserIdToAddresses < ActiveRecord::Migration
  def change
    add_reference(:addresses, :addressable, polymorphic: true)
  end
end

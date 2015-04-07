class Artist < ActiveRecord::Base
  belongs_to :user
  has_one :merchant_address, as: :addressable, class_name: "Address"
  has_many :products
end

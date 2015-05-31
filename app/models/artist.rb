class Artist < ActiveRecord::Base
  belongs_to :user
  has_one :merchant_address, as: :addressable, class_name: "Address"
  has_many :products
  validates :tos, acceptance: true

  def billing_addresses
    user.billing_addresses
  end

  def shipping_addresses
    user.shipping_addresses
  end

  def email
    user.email
  end
end

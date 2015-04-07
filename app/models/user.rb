class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :purchases, foreign_key: :buyer_id
  has_many :items, through: :purchases, source: :product
  has_many :shipping_addresses, as: :addressable, class_name: "Address"
  has_many :billing_addresses, as: :addressable, class_name: "Address"
  has_one :artist

  def cart_count
    $redis.hkeys(cart).count
  end

  def products_in_cart
    cart_ids = $redis.hkeys(cart)
    Product.find(cart_ids)
  end

  def cart
    "cart#{id}"
  end
end

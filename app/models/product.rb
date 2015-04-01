class Product < ActiveRecord::Base
  has_many :purchases
  has_many :buyers, through: :purchases

  def cart_action(current_user_id)
    if $redis.hexists("cart#{current_user_id}", id)
      "Remove from"
    else
      "Add to"
    end
  end

  def checkout(nonce, cart)
    result = Braintree::Transaction.sale(
      amount: total_price(cart),
      payment_method_nonce: nonce
      )
  end

  def quantities_in_cart(cart)
    $redis.hget(cart, id).to_i
  end

  def total_price(cart)
    price * quantities_in_cart(cart)
  end

  def sold_out?
    if quantities <= 0
      errors.add(quantities: "Sorry, #{name} already sold out!")
      return true
    end
  end

  def not_enough?(cart)
    if quantities < quantities_in_cart(cart)
      errors.add(quantities: "Sorry, #{name} doesn't have enough left!")
      return true
    end
  end
end

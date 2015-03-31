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
    checkout_quantities = current_quantities(cart)
    amount = self.price * checkout_quantities
    result = Braintree::Transaction.sale(
      amount: amount,
      payment_method_nonce: nonce
      )
  end

  def current_quantities(cart)
    $redis.hget(cart, id).to_i
  end

  def sold_out?
    if quantities <= 0
      errors.add(quantities: "Sorry, #{name} already sold out!")
      return true
    end
  end

  def not_enough?(cart)
    if quantities < current_quantities(cart)
      errors.add(quantities: "Sorry, #{name} doesn't have enough left!")
      return true
    end
  end
end

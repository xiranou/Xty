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
    quantities <= 0
  end
end

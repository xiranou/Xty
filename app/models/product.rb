class Product < ActiveRecord::Base
  has_many :purchases
  has_many :buyers, through: :purchases

  def cart_action(current_user_id)
    if $redis.sismember "cart#{current_user_id}", id
      "Remove from"
    else
      "Add to"
    end
  end

  def checkout(nonce, current_user)
    result = Braintree::Transaction.sale(
      amount: self.price,
      payment_method_nonce: nonce
      )
  end
end

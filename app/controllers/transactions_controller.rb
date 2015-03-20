class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_cart!

  def new
    gon.client_token = generate_braintree_client_token
  end

  def create
    @product = Product.find(params[:product_id])
    result = @product.checkout(params[:payment_method_nonce], current_user)
    if result.success?
      # TODO Remove product from cart, look into redis
      # $redis.srem(current_user, @product.id)
      redirect_to root_path, notice: "Success!"
    else
      redirect_to root_path, alert: result.errors
    end
  end

  private

  def check_cart!
    if current_user.products_in_cart.blank?
      redirect_to root_url, alert: "Your cart is empty!"
    end
  end

  def generate_braintree_client_token
     Braintree::ClientToken.generate
  end
end

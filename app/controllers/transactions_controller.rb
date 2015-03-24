class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_cart!

  def new
    gon.client_token = generate_braintree_client_token
    @product = Product.find(params[:product_id])
    @quantities = @product.current_quantities(current_user.cart)
  end

  def create
    product = Product.find(params[:product_id])
    result = product.checkout(params[:payment_method_nonce], current_user.cart)
    if result.success?
      $redis.hdel(current_user.cart, product.id)
      flash[:notice] = "Success!"
      current_user.items << product
      if current_user.cart_count > 0
        redirect_to cart_path
      else
        redirect_to root_path
      end
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

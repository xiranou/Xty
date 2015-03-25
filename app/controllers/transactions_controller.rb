class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, :set_quantities, :check_cart!, only: [:new, :create]

  def new
    gon.client_token = generate_braintree_client_token
  end

  def create
    result = @product.checkout(params[:payment_method_nonce], current_user.cart)
    if result.success?
      Purchase.create!(product: @product, buyer: current_user, quantities: @quantities)
      $redis.hdel(current_user.cart, @product.id)
      flash[:notice] = "Success!"
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

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_quantities
    @quantities = set_product.current_quantities(current_user.cart)
  end

  def check_cart!
    if current_user.products_in_cart.blank?
      redirect_to root_url, alert: "Your cart is empty!"
    end
  end

  def generate_braintree_client_token
     Braintree::ClientToken.generate
  end
end

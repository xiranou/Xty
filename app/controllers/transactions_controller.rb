class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, :set_quantities, :check_cart!, only: [:new, :create]

  def new
    gon.client_token = generate_braintree_client_token
  end

  def create
    cart = current_user.cart
    if @product.sold_out? || @product.not_enough?(cart)
      redirect_to root_path, alert: @product.errors.full_messages
    else
      result = @product.checkout(params[:payment_method_nonce], cart)
      if result.success?
        new_purchase(
          product: @product,
          buyer: current_user,
          quantities: @quantities,
          transaction_id: result.transaction.id
          )
        flash[:notice] = "Success! order id: #{result.transaction.id}"
        cart_status_redirect
      else
        redirect_to root_path, alert: result.errors
      end
    end
  end

  private

  def new_purchase(purchase_info={})
    update_cart(purchase_info[:buyer].cart, purchase_info[:product].id)
    Purchase.create!(
      product: purchase_info[:product],
      buyer: purchase_info[:buyer],
      quantities: purchase_info[:quantities],
      transaction_id: purchase_info[:transaction_id]
      )
  end

  def update_cart(cart, product_id)
    $redis.hdel(cart, product_id)
  end

  def cart_status_redirect
    if current_user.cart_count > 0
      redirect_to cart_path
    else
      redirect_to root_path
    end
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_quantities
    @quantities = set_product.quantities_in_cart(current_user.cart)
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

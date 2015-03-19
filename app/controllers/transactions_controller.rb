class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_cart!

  def new
    gon.client_token = generate_braintree_client_token
  end

  def create
    # TODO find the Product
    # use product.checkout(params[:payment_method_nonce]) to send out the checkout
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

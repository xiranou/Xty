class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_cart!
  def new
  end

  private

  def check_cart!
    if current_user.get_cart_movies.blank?
      redirect_to root_url, alert: "Your cart is empty!"
    end
  end
end

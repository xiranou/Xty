class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @current_user_cart = current_user_cart
    cart_ids = $redis.hkeys(@current_user_cart)
    @cart_products = Product.find(cart_ids)
  end

  def add
    $redis.hset(current_user_cart, params[:product_id], params[:quantity])
    render json: current_user.cart_count, status: 200
  end

  def remove
    $redis.hdel(current_user_cart, params[:product_id])
    render json: current_user.cart_count, status: 200
  end

  private

  include UserCart
end

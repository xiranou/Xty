class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @current_user_cart = current_user.cart
    product_ids = $redis.hkeys(@current_user_cart)
    @cart_products = Product.find(product_ids)
  end

  def add
    $redis.hset(current_user.cart, params[:product_id], params[:quantity])
    render json: current_user.cart_count, status: 200
  end

  def remove
    $redis.hdel(current_user.cart, params[:product_id])
    render json: current_user.cart_count, status: 200
  end
end

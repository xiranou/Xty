class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    cart = current_user.cart
    product_ids = $redis.hkeys(cart)
    @product_info_array = product_ids.map do |product_id|
      {product: Product.find(product_id), quantities: get_product_quantities(cart, product_id)}
    end
  end

  def add
    $redis.hset(current_user.cart, params[:product_id], params[:quantity])
    render json: current_user.cart_count, status: 200
  end

  def remove
    $redis.hdel(current_user.cart, params[:product_id])
    render json: current_user.cart_count, status: 200
  end

  private

  def get_product_quantities(cart, product_id)
    $redis.hget(cart, product_id).to_i
  end
end

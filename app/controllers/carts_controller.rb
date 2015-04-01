class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    cart = current_user.cart
    product_ids = $redis.hkeys(cart)
    products_in_cart = Product.find(product_ids)
    @product_info_array = products_in_cart.map do |product|
      { product: product,
        quantities: product.current_quantities(cart),
        total: product.total_price(cart)}
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
end

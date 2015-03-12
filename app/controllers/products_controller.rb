class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
    @products = Product.all
  end

  def show
    @cart_action = @product.cart_action(current_user.try(:id))
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end

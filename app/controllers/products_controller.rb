class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  before_action :current_user_id, only: [:index, :show]

  def index
    @products = Product.all
  end

  private

  def current_user_id
    current_user.try(:id)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end

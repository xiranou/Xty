class AddressesController < ApplicationController
  before_action :authenticate_user!

  def index
    @shipping_addresses = current_user.shipping_addresses
    @billing_addresses = current_user.billing_addresses
  end
end

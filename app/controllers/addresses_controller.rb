class AddressesController < ApplicationController
  before_action :authenticate_user!

  def index
    @shipping_addresses = current_user.shipping_addresses
    @billing_addresses = current_user.billing_addresses
  end

  def new
    @address = if params[:type] == "shipping"
      current_user.shipping_addresses.new
    elsif params[:type] == "billing"
      current_user.billing_addresses.new
    end
    @city = @address.build_city
    @zipcode = @city.zipcodes.new
    @states = State.all
  end
end

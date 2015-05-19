class AddressesController < ApplicationController
  before_action :authenticate_user!

  def index
    @shipping_addresses = current_user.shipping_addresses
    @billing_addresses = current_user.billing_addresses
  end

  def new
    @address = new_address
    @city, @zipcode, @states = City.new, Zipcode.new, State.all
  end

  def create
    city = City.find_or_create_by(city_params)
    zipcode = Zipcode.find_or_create_by(zipcode_params.merge({city: city}))

    address = new_address(city, zipcode)

    if address.save!
      redirect_to addresses_path, notice: "Save!"
    else
      redirect_to new_address_path(params[:tyepe]), alter: address.errors.full_messages
    end
  end

  private

  def address_params
    params.require(:address).permit!
  end

  def city_params
    address_params[:city]
  end

  def zipcode_params
    address_params[:zipcode]
  end

  def new_address(city=nil, zipcode=nil)
    if city.nil? && zipcode.nil?
      build_address
    else
      create_address(city, zipcode)
    end
  end

  def build_address
    if params[:type] == "shipping"
      current_user.shipping_addresses.build
    else
      current_user.billing_addresses.build
    end
  end

  def create_address(city, zipcode)
    if params[:type] == 'shipping'
      current_user.shipping_addresses.new(address_params.merge({city: city}).merge({zipcode: zipcode}))
    else
      current_user.billing_addresses.new(address_params.merge({city: city}).merge({zipcode: zipcode}))
    end
  end
end

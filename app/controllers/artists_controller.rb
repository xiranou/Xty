class ArtistsController < ApplicationController
  before_action :authenticate_user!

  def new
    @artist = current_user.build_artist
  end

  def create
    parse_params(params)
    render text: params
  end

  def parse_params(user_params)
    user_params.each do |section, info|
      case section
      when "individual", "business"
        info[:address] = parse_address(info[:address])
      end
    end
  end

  def parse_address(address_id)
    address = Address.find(address_id)
    {
      street_address: address.street_address,
      locality: address.city.name,
      region: address.state.abbrv,
      postal_code: address.zipcode.zip
    }
  end
end

class ArtistsController < ApplicationController
  before_action :authenticate_user!

  def new
    @artist = current_user.build_artist
  end

  def create
    parse_params(params)
    parse_date(params)
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

  def parse_date(user_params)
    date = Date.new(
        user_params[:individual]["date_of_birth(1i)"].to_i,
        user_params[:individual]["date_of_birth(2i)"].to_i,
        user_params[:individual]["date_of_birth(3i)"].to_i
      ).strftime("%Y-%m-%d")
    user_params[:individual][:date_of_birth] = date
    user_params[:individual].delete("date_of_birth(1i)")
    user_params[:individual].delete("date_of_birth(2i)")
    user_params[:individual].delete("date_of_birth(3i)")
  end
end

class ArtistsController < ApplicationController
  before_action :authenticate_user!

  def new
    @artist = current_user.build_artist
  end

  def create
    parse_address_params
    parse_date_params
    render text: params
  end

  private

  def parse_address_params
    params.slice(:individual, :business).each do |section, info|
      info[:address] = parse_address(info[:address])
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

  def parse_date_params
    date = Date.new(
        params[:individual]["date_of_birth(1i)"].to_i,
        params[:individual]["date_of_birth(2i)"].to_i,
        params[:individual]["date_of_birth(3i)"].to_i
      ).strftime("%Y-%m-%d")
    params[:individual][:date_of_birth] = date
    params[:individual].delete("date_of_birth(1i)")
    params[:individual].delete("date_of_birth(2i)")
    params[:individual].delete("date_of_birth(3i)")
  end
end

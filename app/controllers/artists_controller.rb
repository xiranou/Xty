class ArtistsController < ApplicationController
  before_action :authenticate_user!

  def new
    @artist = current_user.build_artist
  end

  def create
    result = Braintree::MerchantAccount.create(generate_braintree_params)
    render text: result.inspect
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

  def parse_funding_params
    params[:funding][:destination] = Braintree::MerchantAccount::FundingDestination::Bank
  end

  def parse_tos
    params[:tos_accepted] = if params[:tos] == '1'
      true
    else
      false
    end
  end

  def generate_braintree_params
    parse_address_params
    parse_date_params
    parse_funding_params
    parse_tos
    params[:master_merchant_account_id] = ENV['BRAINTREE_MERCHANT_ID']
    params.slice(
      :individual,
      :business,
      :tos_accepted,
      :master_merchant_account_id
    )
  end
end

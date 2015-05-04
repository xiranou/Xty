class Address < ActiveRecord::Base
  belongs_to :city
  belongs_to :zipcode
  belongs_to :addressable, polymorphic: true

  accepts_nested_attributes_for :city

  def full_address
    "#{street_address}, #{city}, #{city.state}, #{zipcode}"
  end
end

class Address < ActiveRecord::Base
  before_create :capitalize_name

  belongs_to :city
  belongs_to :zipcode
  belongs_to :addressable, polymorphic: true

  def full_address
    "#{street_address}, #{city.name}, #{city.state.abbrv}, #{zipcode.zip}"
  end

  def state
    city.state
  end

  private

  def capitalize_name
    self.street_address = self.street_address.split(" ").map(&:capitalize).join(" ")
  end
end
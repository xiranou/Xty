class Address < ActiveRecord::Base
  belongs_to :city
  belongs_to :zipcode
  belongs_to :addressable, polymorphic: true
end

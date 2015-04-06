class Zipcode < ActiveRecord::Base
  has_many :addresses
  belongs_to :city
end

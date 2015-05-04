class City < ActiveRecord::Base
  has_many :addresses
  has_many :zipcodes
  belongs_to :state

  accepts_nested_attributes_for :zipcodes
end

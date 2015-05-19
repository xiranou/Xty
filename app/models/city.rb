class City < ActiveRecord::Base
  before_create :capitalize_name

  has_many :addresses
  has_many :zipcodes
  belongs_to :state

  private

  def capitalize_name
    self.name = self.name.split(" ").map(&:capitalize).join(" ")
  end
end

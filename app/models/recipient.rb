class Recipient < ActiveRecord::Base
  attr_accessible :CountryCode, :OptOut, :Phone
  validates :Phone, :uniqueness => true, :presence => true 
end

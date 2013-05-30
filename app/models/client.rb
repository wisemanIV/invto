class Client < ActiveRecord::Base
  attr_accessible :title, :contactemail, :defaulturl, :urlscheme, :domain
  has_many :shareable 
  has_many :message 
  has_many :email
  validates_presence_of :urlscheme, :domain
end

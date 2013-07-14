class Client < ActiveRecord::Base
  attr_accessible :title, :contactemail, :defaulturl, :urlscheme, :domain, :clients_attributes
  has_many :shareable 
  has_many :message 
  has_many :sms_response
  has_many :email
  validates_presence_of :urlscheme, :domain
  belongs_to :user
end

class Client < ActiveRecord::Base
  attr_accessible :title, :contactemail, :default_url, :default_android_url, :android_scheme, :default_ios_url, :ios_scheme, :domain, :clients_attributes
  has_many :shareable 
  has_many :message 
  has_many :sms_response
  has_many :recipients
  has_many :email
  has_many :recordings
  has_many :client_numbers
  validates_presence_of :domain
  has_many :users
end

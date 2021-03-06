class Recipient < ActiveRecord::Base
  include FormatterModule
  attr_accessible :CountryCode, :OptOut, :Phone, :client_id
  validates :Phone, :uniqueness => true, :presence => true
  validates_presence_of :client_id
  belongs_to :client, :dependent => :destroy
  
  def self.opted_out?(phone)
    !Recipient.where(:OptOut => true, :Phone => phone).first.nil?
  end
  
end

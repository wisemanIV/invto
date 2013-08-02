class ClientNumber < ActiveRecord::Base
  include FormatterModule
  attr_accessible :client_id, :phone
  validates :phone, :uniqueness => true, :presence => true
  belongs_to :client, :dependent => :destroy
  
  
  def self.get_number(cid)
    ClientNumber.where(:client_id => cid).order('random()').first.phone
  end
end

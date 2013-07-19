class ClientNumber < ActiveRecord::Base
  attr_accessible :client_id, :phone
  validates :phone, :uniqueness => true, :presence => true
  belongs_to :client, :dependent => :destroy
  
end

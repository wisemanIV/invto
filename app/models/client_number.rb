class ClientNumber < ActiveRecord::Base
  attr_accessible :client_id, :phone
  belongs_to :client, :dependent => :destroy
  
end

class Click < ActiveRecord::Base
  attr_accessible :actualurl, :browser, :defaulturl, :device, :targeturl, :client_id, :ref
  validates_presence_of :targeturl,:ref,:client_id
  belongs_to :client
end

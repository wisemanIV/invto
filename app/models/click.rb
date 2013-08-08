class Click < ActiveRecord::Base
  attr_accessible :actualurl, :browser, :defaulturl, :device, :targeturl, :client_id, :shareable_id, :user_agent
  validates_presence_of :targeturl, :client_id, :shareable_id
  belongs_to :shareable
end

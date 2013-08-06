class Recording < ActiveRecord::Base
  attr_accessible :tag, :url, :client_id, :user_id
  validates_presence_of :url, :client_id, :user_id
end

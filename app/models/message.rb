class Message < ActiveRecord::Base
  attr_accessible :body, :from, :to, :client_id, :ref
  validates_presence_of :body, :to, :from, :client_id
  belongs_to :client
end

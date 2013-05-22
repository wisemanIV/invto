class Message < ActiveRecord::Base
  attr_accessible :body, :from, :ref, :to
end

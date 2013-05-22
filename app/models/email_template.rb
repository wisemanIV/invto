class EmailTemplate < ActiveRecord::Base
  attr_accessible :body, :name, :subject
end

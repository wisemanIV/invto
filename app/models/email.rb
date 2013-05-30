class Email < ActiveRecord::Base
  attr_accessible :template_id, :from, :fromname, :to, :toname, :client_id, :ref
  validates_presence_of :to, :from, :template_id, :client_id
  has_one :email_template
  belongs_to :client
end

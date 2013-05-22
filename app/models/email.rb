class Email < ActiveRecord::Base
  attr_accessible :from, :fromname, :ref, :template, :to, :toname
end

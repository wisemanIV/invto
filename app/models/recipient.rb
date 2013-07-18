class Recipient < ActiveRecord::Base
  attr_accessible :CountryCode, :OptOut, :Phone, :client_id
  validates :Phone, :uniqueness => true, :presence => true
  validates_presence_of :body, :client_id, :OptOut 
  belongs_to :client, :dependent => :destroy
  
  def formatted_created_at
    datetime = created_at.in_time_zone("Pacific Time (US & Canada)")
    datetime.strftime('%m/%d/%y %H:%M:%S')
  end
  
  def formatted_updated_at
    datetime = updated_at.in_time_zone("Pacific Time (US & Canada)")
    datetime.strftime('%m/%d/%y %H:%M:%S')
  end
end

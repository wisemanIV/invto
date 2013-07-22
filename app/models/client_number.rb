class ClientNumber < ActiveRecord::Base
  attr_accessible :client_id, :phone
  validates :phone, :uniqueness => true, :presence => true
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

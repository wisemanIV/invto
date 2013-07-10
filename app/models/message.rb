class Message < ActiveRecord::Base
  attr_accessible :body, :from, :to, :status, :campaign, :version, :user_id
  validates_presence_of :body, :from, :to
  belongs_to :client
  
  def formatted_created_at
    datetime = created_at.in_time_zone("Pacific Time (US & Canada)")
    datetime.strftime('%m/%d/%y %H:%M:%S')
  end
  
  def formatted_updated_at
    datetime = updated_at.in_time_zone("Pacific Time (US & Canada)")
    datetime.strftime('%m/%d/%y %H:%M:%S')
  end
  
end

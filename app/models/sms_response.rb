class SmsResponse < ActiveRecord::Base
  attr_accessible :AccountSid, :Body, :From, :FromCity, :FromCountry, :FromState, :FromZIP, :SMSId, :To, :ToCity, :ToCountry, :ToState, :ToZIP, :user_id
  belongs_to :client
  validates_presence_of :AccountSid, :SMSId
  before_save :check_opt_out
  before_save :check_help


  def check_opt_out
    puts "CHECKING FOR OPT OUT - #{:Body}"
  end
  
  def check_opt_out
    puts "CHECKING FOR HELP REQUESTED - #{:Body}"
  end
  
  def formatted_created_at
    datetime = created_at.in_time_zone("Pacific Time (US & Canada)")
    datetime.strftime('%m/%d/%y %H:%M:%S')
  end
  
  def formatted_updated_at
    datetime = updated_at.in_time_zone("Pacific Time (US & Canada)")
    datetime.strftime('%m/%d/%y %H:%M:%S')
  end
end
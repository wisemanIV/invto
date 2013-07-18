require 'twilio-ruby'

class Message < ActiveRecord::Base
  attr_accessible :body, :from, :to, :status, :campaign, :version, :user_id, :SmsId, :TwilioResponse, :client_id
  validates_presence_of :body, :from, :to, :user_id, :client_id
  belongs_to :client, :dependent => :destroy
  
  def formatted_created_at
    datetime = created_at.in_time_zone("Pacific Time (US & Canada)")
    datetime.strftime('%m/%d/%y %H:%M:%S')
  end
  
  def formatted_updated_at
    datetime = updated_at.in_time_zone("Pacific Time (US & Canada)")
    datetime.strftime('%m/%d/%y %H:%M:%S')
  end
  
  def self.is_valid_phone(phone)
    
    patt = Regexp.new('^\+?1?[2-9][0-9]{2}[2-9][0-9]{2}[0-9]{4}$')
    
    if !phone.nil? && !phone.blank? && !phone.match(patt).nil?
      true
    else
      false
    end
  end
  
  def self.clean_phone_number(phone)
     phone.gsub(/\s+|\[|\]|\(|\)|\-|\_|\.|\{|\}|\@|\~|\<|\>|\?|\\|\/|\#|\!|\%|\*|\&/, "") #clean string
  end
end

require 'twilio-ruby'

class Message < ActiveRecord::Base
  attr_accessible :body, :from, :to, :status, :campaign, :version, :user_id, :SmsId, :TwilioResponse
  validates_presence_of :body, :from, :to
  belongs_to :client, :dependent => :destroy
  
  def formatted_created_at
    datetime = created_at.in_time_zone("Pacific Time (US & Canada)")
    datetime.strftime('%m/%d/%y %H:%M:%S')
  end
  
  def formatted_updated_at
    datetime = updated_at.in_time_zone("Pacific Time (US & Canada)")
    datetime.strftime('%m/%d/%y %H:%M:%S')
  end
  
  def self.process 
    @messages = Message.where("status = 'submitted'")
  
    @messages.each do |message|
    
      @opt_out = Recipient.where(:OptOut => true, :Phone => message.to).first
    
    #  if !@opt_out.nil?
    #    puts "CANNOT SEND - PHONE IS OPTED OUT #{message.to}"
    #    message.status = 'opted out'
    #    message.save
    #  else
   #     begin
          account_sid = ENV["TWILIO_SID"]
          auth_token = ENV["TWILIO_TOKEN"]

          @client = Twilio::REST::Client.new account_sid, auth_token

          res = @client.account.sms.messages.create(
          :from => message.from,
          :to => message.to,
          :body => message.body,
          :status_callback => 'http://inv.to/sms/callback'
          )
      
          puts "GOT A SID #{res.sid}"
    
          message.SmsId = res.sid
          message.status = 'processing'
  
          message.save
      
    #    rescue Twilio::Rest::RequestError => e
     #     puts "TWILIO API ERROR #{e.message} #{message.to}"
    #      message.status = 'api error'
    #      message.save
    #    end
    #  end
    end

  end
  
end

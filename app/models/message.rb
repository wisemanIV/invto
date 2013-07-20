require 'twilio-ruby'

class Message < ActiveRecord::Base
  attr_accessible :body, :from, :to, :status, :campaign, :version, :user_id, :SmsId, :TwilioResponse, :client_id
  validates_presence_of :body, :to, :user_id, :client_id
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
  
  def send_sms!
   
    if self.status == 'submitted'
      self.status == 'processing'
      self.save!

      begin 
        @opt_out = Recipient.where(:OptOut => true, :Phone => self.to).first

        if !@opt_out.nil?
          puts "CANNOT SEND - PHONE IS OPTED OUT #{self.to}"
          self.status = 'opted out'
          self.save!
        else
          account_sid = ENV["TWILIO_SID"]
          auth_token = ENV["TWILIO_TOKEN"]

          begin
            @client = Twilio::REST::Client.new account_sid, auth_token
            from = ClientNumber.where(:client_id => self.client_id).order('random()').first.phone

            res = @client.account.sms.messages.create(
            :from => from,
            :to => self.to,
            :body => self.body,
            :status_callback => ENV["CALLBACK_URL"]
            )
          rescue Twilio::REST::RequestError
            puts "TWILIO CLIENT ERROR"
            self.status = 'twilio api error'
            self.save!
          end
  
          puts "GOT A SID #{res.sid}"

          self.SmsId = res.sid
          self.status = 'processing'
          self.from = from 

          self.save!
        end
      rescue Exception => e
        puts "ERROR PROCESSING MESSAGE #{self.to}" 
        puts "#{e} exception while handling connection: #{e.message}"
        self.status = 'error'
        self.save!
        raise 
      end
    end
  end
end

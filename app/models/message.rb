require 'twilio-ruby'

class Message < ActiveRecord::Base
  include FormatterModule
  attr_accessible :body, :remote_attachment_url, :from, :to, :status, :attachment, :campaign, :version, :user_id, :SmsId, :TwilioResponse, :client_id
  validates_presence_of :body, :to, :user_id, :client_id
  belongs_to :client, :dependent => :destroy
  mount_uploader :attachment, AttachmentUploader
  
  def self.is_valid_phone(phone)
    
    patt = Regexp.new('^\+?1?[2-9][0-9]{2}[2-9][0-9]{2}[0-9]{4}$')
    
    !phone.nil? && !phone.blank? && !phone.match(patt).nil?
    
  end
  
  def self.clean_phone_number(phone)
    phone.gsub(/\s+|\[|\]|\(|\)|\-|\_|\.|\{|\}|\@|\~|\<|\>|\?|\\|\/|\#|\!|\%|\*|\&/, "") #clean string
  end
  
  def self.get_message_array(str)
    str = Message.clean_phone_number(str) 
    str.split(/,/)
  end
  
  def self.get_country_code(phone)
    @cc = phone.strip[/^\+\d/]
    if @cc.nil? 
      @cc = "+1"
    else
      @cc
    end
  end
  
  def self.less_country_code(phone)
    phone.strip.gsub(/^\+\d/,"")
  end
  
  def self.handle_sms_sent(sms_id)
    @message = Message.where(:SmsId => sms_id).first
    @message.status = 'sent'
    @message.save
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
          
          if self.attachment? 
            
            client = Mogreet::Client.new(ENV["MOGREET_CLIENT_ID"], ENV["MOGREET_SECRET_TOKEN"])
  
            res = client.transaction.send(
              :campaign_id => ENV["MOGREET_MMS_CAMPAIGN_ID"], 
              :to          => self.to, 
              :message     => self.body, 
              :content_url => self.attachment_url
              :callback    => "http://inv.to/api/sms/callback"
            )
            self.SmsId = res.message_id
            self.status = 'processing'

            self.save!
            
          else
            
            account_sid = ENV["TWILIO_SID"]
            auth_token = ENV["TWILIO_TOKEN"]

            begin
              @client = Twilio::REST::Client.new account_sid, auth_token
              from = ClientNumber.get_number(self.client_id)

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

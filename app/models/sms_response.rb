class SmsResponse < ActiveRecord::Base
  include FormatterModule
  attr_accessible :AccountSid, :Body, :From, :FromCity, :FromCountry, :FromState, :FromZIP, :SMSId, :To, :ToCity, :ToCountry, :ToState, :ToZIP, :client_id, :attachment, :remote_attachment_url
  belongs_to :client, :dependent => :destroy
  validates_presence_of :client_id
  before_save :check_opt_out
  before_save :check_help
  mount_uploader :attachment, AttachmentUploader

  def self.handle_twilio_response(provider, sms_id, account_sid, into, infrom, body, city, state, zip, country)
    
    to = Message.clean_phone_number(into)
    from = Message.clean_phone_number(infrom)
    client = ClientNumber.where(:phone => to).first
    
    if client.nil? 
      puts "ERROR: TWILIO CLIENT NOT RECOGNIZED #{into}"
    else
    
      @sms = SmsResponse.new(:SMSId => sms_id, :AccountSid => account_sid, :To => to, :From => from, :Body => body, :FromCity => city, :FromState => state, :FromZIP => zip, :FromCountry => country, :client_id => client.id)
    
      if @sms.nil? || !@sms.save then
        puts "HANDLE RESPONSE ERROR! #{provider} , #{sms_id} "
        puts @sms.errors.full_messages
      end
    end
  
  end
  
  def self.handle_mogreet_response(provider, campaign_id, sms_id, into, infrom, body, image)
    
    to = Message.clean_phone_number(into)
    from = Message.clean_phone_number(infrom)
    client = Client.where(:mogreet_campaign_id => campaign_id).first
    
    if client.nil? 
      puts "ERROR: MOGREET CLIENT NOT RECOGNIZED #{campaign_id}"
    else
    
      @sms = SmsResponse.new(:SMSId => sms_id, :To => to, :From => from, :Body => body, :client_id => client.id, :remote_attachment_url => image)
    
      if @sms.nil? || !@sms.save then
        puts "HANDLE RESPONSE ERROR! #{provider} , #{sms_id} "
        puts @sms.errors.full_messages
      end
    end
  
  end

  def check_opt_out
    
    puts "CHECKING FOR OPT OUT - #{:Body}"
    
    if SmsResponse.opt_out_request(self.Body) then
     
      cc = Message.get_country_code(self.From)
      from = Message.less_country_code(self.From)
      recipient = Recipient.where(:Phone => from).first
      
      client = ClientNumber.where(:phone => self.To)
      
      if client.nil? 
        puts "ERROR: CLIENT NOT RECOGNIZED #{self.To}"
      else
         client = client.first.client_id
         if recipient.nil? 
           recipient = Recipient.new(:CountryCode => cc, :Phone => from, :OptOut => true, :client_id => client)
         else
           recipient.OptOut = true 
         end
         recipient.save 
       end
    end
    
  end
  
  def self.opt_out_request(msg)
     !msg.blank? && (msg.downcase.include?('STOP'.downcase) || msg.downcase.include?('CANCEL'.downcase) || msg.downcase.include?('UNSUBSCRIBE'.downcase)|| msg.downcase.include?('QUIT'.downcase))
  end
  
  def check_help
    puts "CHECKING FOR HELP REQUESTED - #{:Body}"
  end

end

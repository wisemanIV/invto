class Message < ActiveRecord::Base
  include FormatterModule, MogreetUtil, TwilioUtil
  attr_accessible :body, :remote_attachment_url, :from, :to, :status, :attachment, :campaign, :version, :user_id, :SmsId, :TwilioResponse, :client_id
  validates_presence_of :body, :to, :user_id, :client_id
  belongs_to :client, :dependent => :destroy
  mount_uploader :attachment, AttachmentUploader
  
  $MESSAGE_STATUS = ["initial", "submitted", "processing", "awaiting response", "sent", "error", "opted-out", "invalid phone", "twilio api error"]
  
  def as_json(options={})
    super(options.merge({ :only => [:body, :remote_attachment_url, :from, :to, :status, :attachment, :campaign, :version, :user_id, :SmsId, :TwilioResponse, :client_id]}))
  end
  
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
    @message.status = $MESSAGE_STATUS[4] #sent
    @message.save
  end
  
  def self.archive
    @messages = Message.where(:status => $MESSAGE_STATUS[4]) #sent
  
    @messages.each do |message|
      @archive = SmsArchive.new(:campaign => message.campaign, :version => message.version, :from => message.from, :to => message.to, :body => message.body, :status => message.status, :user_id => message.user_id, :sms_id => message.SmsId, :client_id => message.client_id, :processed_date => message.updated_at, :entered_date => message.created_at)
      if @archive.save then
        message.delete
      end
    end
  end
  
  def send_sms!
   
    if self.status == $MESSAGE_STATUS[1] #sent
      self.status == $MESSAGE_STATUS[2] #processing 
      self.save!

      begin 
       
        if @Recipient.opted_out?(self.to)
          puts "CANNOT SEND - PHONE IS OPTED OUT #{self.to}"
          self.status = $MESSAGE_STATUS[6]  # opted out
          self.save!
        else
          
          if self.attachment?    
            send_mogreet
          else 
            send_twilio
          end
        end
      rescue Exception => e
        puts "ERROR PROCESSING MESSAGE #{self.to}" 
        puts "#{e} exception while handling connection: #{e.message}"
        self.status = $MESSAGE_STATUS[5]  # error
        self.save!
        raise 
      end
    end
  end
end

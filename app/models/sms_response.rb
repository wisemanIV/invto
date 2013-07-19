class SmsResponse < ActiveRecord::Base
  attr_accessible :AccountSid, :Body, :From, :FromCity, :FromCountry, :FromState, :FromZIP, :SMSId, :To, :ToCity, :ToCountry, :ToState, :ToZIP, :client_id
  belongs_to :client, :dependent => :destroy
  validates_presence_of :AccountSid, :SMSId, :client_id
  before_save :check_opt_out
  before_save :check_help


  def check_opt_out
    
    puts "CHECKING FOR OPT OUT - #{:Body}"
    
    if !self.Body.blank? && (self.Body.include?('STOP') || self.Body.include?('CANCEL') || self.Body.include?('UNSUBSCRIBE')|| self.Body.include?('QUIT'))
      from = Message.clean_phone_number(self.From)
      recipient = Recipient.where(:Phone => from).first
      
      client = ClientNumber.where(:phone => self.To).first.id
      
      if client.nil? 
        puts "ERROR: CLIENT NOT RECOGNIZED #{self.To}"
      else
         client = client.first.id
         if recipient.nil? 
           recipient = Recipient.new(:Phone => from, :OptOut => true, :client_id => client)
         else
           recipient.OptOut = true 
         end
         recipient.save 
       end
    end
    
  end
  
  def check_help
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

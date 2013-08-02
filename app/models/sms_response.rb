class SmsResponse < ActiveRecord::Base
  include FormatterModule
  attr_accessible :AccountSid, :Body, :From, :FromCity, :FromCountry, :FromState, :FromZIP, :SMSId, :To, :ToCity, :ToCountry, :ToState, :ToZIP, :client_id
  belongs_to :client, :dependent => :destroy
  validates_presence_of :AccountSid, :SMSId, :client_id
  before_save :check_opt_out
  before_save :check_help

  def self.handle_sms_response(arr)
    
    to = Message.clean_phone_number(arr[:To])
    from = Message.clean_phone_number(arr[:From])
    client = ClientNumber.where(:phone => to)
    
    if client.nil? 
      puts "ERROR: CLIENT NOT RECOGNIZED #{params[:To]}"
    else
      client = client.first.client_id
    
      @sms = SmsResponse.new(:SMSId => arr[:SmsSid], :AccountSid => arr[:AccountSid], :To => to, :From => from, :Body => arr[:Body], :FromCity => arr[:FromCity], :FromState => arr[:FromState], :FromZIP => arr[:FromZIP], :FromCountry => arr[:FromCountry], :client_id => client)
    
      if @sms.nil? || !@sms.save then
        puts "CALLBACK ERROR!"
        puts @sms.errors.full_messages
      end
    end
  
  end

  def check_opt_out
    
    puts "CHECKING FOR OPT OUT - #{:Body}"
    
    if self.opt_out_request(:Body) then
     
      cc = Message.get_country_code(self.From)
      from = Message.less_country_code(self.From)
      recipient = Recipient.where(:Phone => from).first
      
      client = ClientNumber.where(:phone => self.To).first.id
      
      if client.nil? 
        puts "ERROR: CLIENT NOT RECOGNIZED #{self.To}"
      else
         client = client.first.id
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

require 'twilio-ruby'

module TwilioUtil
  
  def send_twilio
   
    account_sid = ENV["TWILIO_SID"]
    auth_token = ENV["TWILIO_TOKEN"]

    begin
      @client = Twilio::REST::Client.new account_sid, auth_token
      from = ClientNumber.get_number(self.client_id)
      self.from = from

      res = @client.account.sms.messages.create(
      :from => from,
      :to => self.to,
      :body => self.body,
      :status_callback => ENV["TWILIO_CALLBACK_URL"]
      )
    rescue Twilio::REST::RequestError
      puts "TWILIO CLIENT ERROR"
      self.status = $MESSAGE_STATUS[8] 
      self.save!
      raise
    end
    
    self.SmsId = res.sid
    self.status = $MESSAGE_STATUS[3] #awaiting response

    self.save!
  
  end
  
  
end

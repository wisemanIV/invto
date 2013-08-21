module MogreetUtil
  
  def send_mogreet
   
    begin 
      client = Mogreet::Client.new(ENV["MOGREET_CLIENT_ID"], ENV["MOGREET_SECRET_TOKEN"])
      
      puts "ATTACHMENT URL #{self.attachment.attached_url}"
      
      res = client.transaction.send(
        :campaign_id => ENV["MOGREET_MMS_CAMPAIGN_ID"], 
        :to          => self.to, 
        :message     => self.body, 
        :content_url => self.attachment.attached_url
      )
    rescue => e
      puts "MOGREET ERROR #{e}"
      self.status = $MESSAGE_STATUS[5] # error 
      self.save!
      raise
    end
    
    self.SmsId = res.message_id
    self.status = $MESSAGE_STATUS[3] #awaiting response
    self.save!
  
  end
  
  
end

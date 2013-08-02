namespace :inv do
  task :sendsms => :environment do
    
    @messages = Message.where("status = 'submitted'")
  
    @messages.each do |message|
    
      @opt_out = Recipient.where(:OptOut => true, :Phone => message.to).first
    
      if !@opt_out.nil?
        puts "CANNOT SEND - PHONE IS OPTED OUT #{message.to}"
        message.status = 'opted out'
        message.save
      else
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
      
      end
    end
  end
end
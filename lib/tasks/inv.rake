namespace :inv do
  task :sendsms => :environment do
    
    @messages = Message.where("status <> 'sent'")
   
    @messages.each do |message|
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
      message.status = 'twilio'
    
      message.save
    end

  end
end
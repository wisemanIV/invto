namespace :inv do
  desc "TODO"
  task :sendsms => :environment do
    
    @messages = Message.where("status <> 'sent'")
   
    @messages.each do |message|
      account_sid = ENV["TWILIO_SID"]
      auth_token = ENV["TWILIO_TOKEN"]

      @client = Twilio::REST::Client.new account_sid, auth_token

      @client.account.sms.messages.create(
      :from => message.from,
      :to => message.to,
      :body => message.body
      )
      
      message.status = 'sent'
      puts "Message #{message.id} sent"
      
      message.save
    end

  end
end
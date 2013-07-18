namespace :inv do
  task :sendsms => :environment do
    process_sms
  end
end

def process_sms

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

      begin
      @client = Twilio::REST::Client.new account_sid, auth_token

      res = @client.account.sms.messages.create(
      :from => message.from,
      :to => message.to,
      :body => message.body,
      :status_callback => ENV["CALLBACK_URL"]
      )
      rescue Twilio::REST::RequestError
        puts "TWILIO CLIENT ERROR"
        message.status = 'twilio api error'
        message.save
      end
  
      puts "GOT A SID #{res.sid}"

      message.SmsId = res.sid
      message.status = 'processing'

      message.save
  
  end
end

end
namespace :inv do
  task :sendsms => :environment do
    
    @messages = Message.where("status = 'submitted'")
  
    @messages.each do |message|
      message.delay.send_sms!
    end
  end
  
  task :archivesms => :environment do
    
    Message.archive
    
  end
end
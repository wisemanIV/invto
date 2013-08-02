namespace :inv do
  task :sendsms => :environment do
    
    @messages = Message.where("status = 'submitted'")
  
    @messages.each do |message|
      message.delay.send_sms!
    end
  end
  
  task :archivesms => :environment do
    
    @messages = Message.where("status = 'sent'")
  
    @messages.each do |message|
      @archive = SmsArchive.new(message.attributes)
      if @archive.save then
        message.delete
      end
    end
  end
end
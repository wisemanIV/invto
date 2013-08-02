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
      @archive = SmsArchive.new(:campaign => message.campaign, :version => message.version, :from => message.from, :to => message.to, :body => message.body, :status => message.status, :user_id => message.user_id, :sms_id => message.SmsId, :client_id => message.client_id, :processed_date => message.updated_at, :entered_date => message.created_at)
      if @archive.save then
        message.delete
      end
    end
  end
end
class CallbackController < ApplicationController
  skip_authorization_check
  private

  def use_https?
    false
  end
  
  # POST /sms/callback
  def create
    puts "CALLBACK INITIATED"
    
    if params[:SmsStatus].blank? || params[:SmsStatus]=='received'
      @sms = SmsResponse.new(:SMSId => params[:SmsSid], :AccountSid => params[:AccountSid], :To => params[:To], :From => params[:From], :Body => params[:Body], :FromCity => params[:FromCity], :FromState => params[:FromState], :FromZIP => params[:FromZIP], :FromCountry => params[:FromCountry])
    else 
      if params[:SmsStatus]=='sent'
        @message = Message.where(:SmsId => params[:SmsSid]).first
        @message.status = 'sent'
        @message.save
      else
        puts "TWILIO REPORTING AN ERROR #{params[:SmsSid]} #{params[:SmsStatus]}"
        
      end
    end
   
    if @sms.nil? || !@sms.save then
      puts "CALLBACK ERROR!"
      puts @sms.errors.full_messages
    end
    
    render nothing: true
  end

end

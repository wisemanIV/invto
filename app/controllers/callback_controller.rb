class CallbackController < ApplicationController
  skip_authorization_check
  
  # POST /sms/callback
  def create
    puts "CALLBACK INITIATED"
    
    if params[:SmsStatus].blank? || params[:SmsStatus]=='received'
        SmsResponse.delay.handle_sms_response(params) 
    else 
      if params[:SmsStatus]=='sent'
        Message.delay.handle_sms_sent(params[:SmsSid])
      else
        puts "TWILIO REPORTING AN ERROR #{params[:SmsSid]} #{params[:SmsStatus]}"   
      end
    end
    
    render nothing: true
  end
  
  private
  def use_https?
    false
  end

end

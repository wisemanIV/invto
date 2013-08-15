module Api
  class CallbackController < ApplicationController
    skip_authorization_check
  
    def mogreet_callback
      puts "MOGREET CALLBACK INITIATED #{params}"
    
      if !params[:response][:status].blank? && params[:response][:status]=='success'
          Message.delay.handle_sms_sent(params[:response][:message_id])
      else
          Message.delay.handle_sms_error("MOGREET", params[:response][:message_id], params[:response][:code], params[:response][:message])
      end
    
      render nothing: true
    
    end
    
    def handle_mogreet_response
      puts "MOGREET RESPONSE INITIATED"
    
      if !params[:event].blank? && params[:event]=='message-in'
          images = params[:images]
          if !images.blank?
            image = images[:image] 
          else
            image = ""
          end
          
          SmsResponse.delay.handle_mogreet_response("MOGREET", params[:campaign_id], params[:message_id], params[:campaign_id], params[:msisdn], params[:message], image)
          
      else if !params[:event].blank? && params[:event]=='reply-y'
          puts "MOGREET REPLY Y"
      else if !params[:event].blank? && params[:event]=='stop'
          puts "MOGREET STOP"
      else
          puts "MOGREET RESPONSE MALFORMED"     
      end
      end
      end
    
      render nothing: true
    
    end
    
    def twilio_callback
      puts "TWILIO CALLBACK INITIATED"
    
      if params[:SmsStatus].blank? || params[:SmsStatus]=='received'
          SmsResponse.delay.handle_twilio_response("TWILIO", params[:SmsSid], params[:AccountSid], params[:To], params[:From], params[:Body], params[:FromCity], params[:FromState], params[:FromZip], params[:FromCountry]) 
      else 
        if params[:SmsStatus]=='sent'
          Message.delay.handle_sms_sent(params[:SmsSid])
        else
          Message.delay.handle_sms_error("TWILIO", params[:SmsSid], "", "")
        end
      end
    
      render nothing: true
    end
  
    private
    def use_https?
      false
    end
  end
end

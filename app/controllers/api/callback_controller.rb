module Api
  class CallbackController < ApplicationController
    skip_authorization_check
    
    respond_to :xml, :json
  
    def mogreet_callback
      puts "MOGREET CALLBACK INITIATED #{params}"
      puts "Request #{request.body.read}"
      
      doc = Nokogiri::XML(request.body.read)
    
      if !doc.xpath('//status').blank? && doc.xpath('//status')=='success'
          Message.delay.handle_sms_sent(doc.xpath('//message_id'))
      else
          Message.delay.handle_sms_error("MOGREET", doc.xpath('//message_id'), doc.xpath('//code'), doc.xpath('//message'))
      end
    
      render nothing: true
    
    end
    
    def handle_mogreet_response
      puts "MOGREET RESPONSE INITIATED #{params}"
      puts "Request #{request.body.read}"
      
      doc = Nokogiri::XML(request.body.read)
    
      if !doc.xpath('//event').blank? && doc.xpath('//event')=='message-in'
          images = doc.xpath('//images')
          if !images.blank?
            image = doc.xpath('//images')
          else
            image = ""
          end
          
          SmsResponse.delay.handle_mogreet_response("MOGREET", doc.xpath('//campaign_id').to_s, doc.xpath('//message_id'), doc.xpath('//campaign_id').to_s, doc.xpath('//msisdn'), doc.xpath('//message'), image)
          
      else if !doc.xpath('//event').blank? && doc.xpath('//event')=='reply-y'
          puts "MOGREET REPLY Y"
          SmsResponse.delay.mogreet_opt_in_out(doc.xpath('//msisdn'),doc.xpath('//campaign_id').to_s,false)
      else if !doc.xpath('//event').blank? && doc.xpath('//event')=='stop'
          puts "MOGREET STOP"
          SmsResponse.delay.mogreet_opt_in_out(doc.xpath('//msisdn'),doc.xpath('//campaign_id').to_s,true)
      else
          puts "MOGREET RESPONSE MALFORMED"     
      end
      end
      end
    
      render nothing: true
    
    end
    
    def twilio_callback
      puts "TWILIO CALLBACK INITIATED #{params}"
    
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

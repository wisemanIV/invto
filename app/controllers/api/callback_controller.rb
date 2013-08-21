module Api
  class CallbackController < ApplicationController
    skip_authorization_check
    
    respond_to :xml, :json
  
   # def mogreet_callback
  #    puts "MOGREET CALLBACK INITIATED #{params}"
  #    puts "Request #{request.body.read}"
      
  #    rb = request.body.read.to_s.gsub(/\s/, "")
      
  #    doc = Nokogiri::XML.fragment(rb)
      
  #    puts "Request #{rb}"
     
      
  #    puts "Status #{doc.xpath('//@status').inner_text}"
    
  #    if !doc.xpath('//@status').inner_text.blank? && doc.xpath('//@status').inner_text=='success'
  #        Message.delay.handle_sms_sent(doc.xpath('//message_id').inner_text)
  #    else
  #        Message.delay.handle_sms_error("MOGREET", doc.xpath('//message_id').inner_text, doc.xpath('//@code').inner_text, doc.xpath('//message').inner_text)
  #    end
    
  #    render nothing: true
    
  #  end
    
    def mogreet_callback
      puts "MOGREET CALLBACK INITIATED #{params}"
      puts "Request body #{request.body.read}"
      puts "Content type #{request.headers['Content-Type']}"
      
      rb = request.body.read.to_s.gsub(/\s,\\n,\n/, "")
      
      doc = Nokogiri::XML(rb,nil, 'UTF-8')
      
      puts "Scope #{doc.xpath('//@status').inner_text}"
    
    
      if !doc.xpath('//@status').blank? && doc.xpath('//@status').inner_text=='success'
          Message.delay.handle_sms_sent(doc.xpath('//message_id').inner_text)
      else if !doc.xpath('//@status').blank?
          Message.delay.handle_sms_error("MOGREET", doc.xpath('//message_id').inner_text, doc.xpath('//@code').inner_text, doc.xpath('//message').inner_text)
      else if !params[:event].blank? && params[:event]=='message-in'
          images = params[:images]
          if !images.blank?
            image = images[:image] 
          else
            image = ""
          end
          
          SmsResponse.delay.handle_mogreet_response("MOGREET", params[:campaign_id].to_s, params[:message_id], params[:campaign_id].to_s, params[:msisdn], params[:message], image)
          
      else if !params[:event].blank? && params[:event]=='reply-y'
          puts "MOGREET REPLY Y"
          SmsResponse.delay.mogreet_opt_in_out(params[:msisdn],params[:campaign_id].to_s,false)
      else if !params[:event].blank? && params[:event]=='stop'
          puts "MOGREET STOP"
          SmsResponse.delay.mogreet_opt_in_out(params[:msisdn],params[:campaign_id].to_s,true)
      else
          puts "MOGREET RESPONSE MALFORMED"     
      end
      end
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

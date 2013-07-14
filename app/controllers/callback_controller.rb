class CallbackController < ApplicationController
  
  # POST /sms/callback
  def create
    puts "CALLBACK INITIATED"
    
    if params[:SmsStatus].blank?
      response = SmsResponse.new(:SMSId => params[:SMSId], :AccountSid => params[:AccountSid], :To => params[:To], :From => params[:From], :Body => params[:Body], :FromCity => params[:FromCity], :FromState => params[:FromState], :FromZIP => params[:FromZIP], :FromCountry => params[:FromCountry])
    else 
      puts "CALLBACK STATUS #{params[:SmsStatus]} SmsId #{params[:SMSId]}"
    end
   
    if !response.save then
      puts "CALLBACK ERROR!"
      puts response.errors.full_messages
    end
    
    render nothing: true
  end

end

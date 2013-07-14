class CallbackController < ApplicationController
  
  # POST /sms/callback
  def create
    puts "CALLBACK INITIATED"
    
    if params[:SmsStatus].blank? || params[:SmsStatus]=='received'
      @sms = SmsResponse.new(:SMSId => params[:SmsSid], :AccountSid => params[:AccountSid], :To => params[:To], :From => params[:From], :Body => params[:Body], :FromCity => params[:FromCity], :FromState => params[:FromState], :FromZIP => params[:FromZIP], :FromCountry => params[:FromCountry])
    else 
      puts "CALLBACK STATUS #{params[:SmsStatus]} SmsId #{params[:SmsSid]}"
    end
   
    if @sms.nil? || !@sms.save then
      puts "CALLBACK ERROR!"
      puts @sms.errors.full_messages
    end
    
    render nothing: true
  end

end

module Api
  class CallbackController < ApplicationController
    skip_authorization_check
  
    def create
      puts "CALLBACK INITIATED"
    
      if !params[:response][:status].blank? && params[:response][:status]=='success'
          Message.delay.handle_sms_sent(params[:response][:message_id])
      end
    
      render nothing: true
    
    end
  end
end

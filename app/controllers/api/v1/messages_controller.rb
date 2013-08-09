module Api
  module V1
    class MessagesController < ApiBaseController
      before_filter :authenticate_user!
      skip_authorization_check

      respond_to :json
  
     
      def index
         
        @messages = Message.where(:client_id => current_user.client_id).all
    
        respond_with @messages
  
      end

      def show
        
        @message = Message.find(params[:id])

        respond_with @message
      end

      def create 
  
        client = Client.find(current_user.client_id)

        if client.nil? 
          respond_with "Error: Cannot create SMS until an application is provisioned on your account.'e".to_json
        else
          # send an sms
          saved = true  
    
          if Message.is_valid_phone(params[:message][:to])
            status = $MESSAGE_STATUS[0] #submitted
          else 
            status = $MESSAGE_STATUS[7] #invalid phone
          end
  
          @message = Message.new(:attachment => params[:message][:attachment], :campaign => params[:message][:campaign], :version => params[:message][:version], :to => params[:message][:to], :body => params[:message][:body], :status => status, :user_id => current_user.id, :client_id => client.id )
  
          if !@message.save
            respond_with "error saving message".to_json
          else
            @message.delay.send_sms!
            respond_with @message
          end
        end
      end

    end
  end
end  
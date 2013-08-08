module Api
  module V1
    class ShareablesController < ApiBaseController
      before_filter :authenticate_user!
      #load_and_authorize_resource
      skip_authorization_check

      respond_to :json

      def create 
    
        client_id = params[:shareable][:client_id]
        
        @shareable = Shareable.new(:campaign => params[:shareable][:campaign], :version => params[:shareable][:version], :client_id => client_id)
        @shareable.save!
        @shareable.shorten!
      
        respond_with @shareable
      end
  
    end
  end
end


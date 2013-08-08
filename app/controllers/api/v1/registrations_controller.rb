module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      skip_authorization_check
      
      respond_to :json
  
      def create
        
        @user = User.create(params[:registration][:user]) 
        
        if @user.save
          respond_to do |format|
            format.json { render :json => @user.authentication_token }
          end
        else
          respond_to do |format|
            format.json { render :json => @user.errors }
          end
           
        end
   
      end
 
    end
  end
end
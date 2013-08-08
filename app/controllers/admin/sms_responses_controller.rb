class Admin::SmsResponsesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
 
  def index
    
    @user = User.find(current_user.id)
    
    @links_grid = initialize_grid(SmsResponse.where(:client_id => @user.client_id))

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sms_responses }
    end
  end
  
  def destroy
    @sms_response = SmsResponse.find(params[:id])
    @sms_response.destroy

    respond_to do |format|
      format.html { redirect_to sms_responses_url }
      format.json { head :no_content }
    end
  end
end

class Admin::SmsResponsesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
 
  respond_with :html
  
  def index
    
    @links_grid = initialize_grid(SmsResponses)
    
    respond_with @links_grid
    
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

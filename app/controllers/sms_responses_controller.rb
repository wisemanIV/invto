class SmsResponsesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    
    @user = User.find(current_user.id)
    
    @links_grid = initialize_grid(SmsResponse.where(:client_id => @user.client_id).order("created_at DESC"))

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @sms_response = SmsResponse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def destroy
    @sms_response = SmsResponse.find(params[:id])
    @sms_response.destroy

    respond_to do |format|
      format.html { redirect_to sms_responses_url }
    end
  end
end

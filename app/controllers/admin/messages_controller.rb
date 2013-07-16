class Admin::MessagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    
    @links_grid = initialize_grid(Message)
    
    respond_to do |format|
      format.html 
      format.json { render json: @message }
    end
  end
end

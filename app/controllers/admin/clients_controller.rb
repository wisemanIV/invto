class Admin::ClientsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    
    @links_grid = initialize_grid(Client)
    
    respond_to do |format|
      format.html 
      format.json { render json: @client }
    end
  end
  
  
end

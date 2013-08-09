class Admin::MessagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  respond_to :html
  
  def index
    
    @links_grid = initialize_grid(Message)
    
    respond_with @links_grid
  end
end

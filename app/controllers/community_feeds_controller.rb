class CommunityFeedsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  respond_to :html
  
  def index
    render action: "index", layout: "community"
  end
  
  private
  def use_https?
    false
  end
end

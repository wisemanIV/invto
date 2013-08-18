class HomeController < ApplicationController
  skip_authorization_check
  
  respond_to :html 
  
  def index
    render action: "index", layout: "home-page"
  end
  
  def contact_us
    render action: "contact", layout: "home-page"
  end
end

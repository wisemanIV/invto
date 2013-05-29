class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  
  private
  
  def iphone_device?
    request.user_agent =~ /iPhone/ 
  end
  helper_method :iphone_device?
    
  def ipad_device?
    request.user_agent =~ /iPad/
  end
  helper_method :ipad_device?
  
  def mobile_device?
    request.user_agent =~ /Mobile|webOS/
  end
  helper_method :mobile_device?
end

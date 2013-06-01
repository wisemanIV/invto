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
  
  
  def after_sign_in_path_for(resource_or_scope)
     new_client_path
  end
end

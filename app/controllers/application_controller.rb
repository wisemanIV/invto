class ApplicationController < ActionController::Base
  before_filter :https_redirect
  
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
    "/user_profiles#show"
  end
  
  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      ApiKey.exists?(access_token: token)
    end
  end

  def https_redirect
    if ENV["ENABLE_HTTPS"] == "yes"
      if request.ssl? && !use_https? || !request.ssl? && use_https?
        protocol = request.ssl? ? "http" : "https"
        flash.keep
        redirect_to protocol: "#{protocol}://", status: :moved_permanently
      end
    end
  end

  def use_https?
    true # Override in other controllers
  end
  
end

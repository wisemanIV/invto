module Api
  class CallbackController < ApplicationController
    skip_authorization_check
  
    # POST /sms/callback
    def create
      puts "CALLBACK INITIATED"
      puts "#{params}"
  end
end

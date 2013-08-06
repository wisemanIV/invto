require 'twilio-ruby'

module Api
    class RecordingsController < ApplicationController
       skip_authorization_check
   
       respond_to :xml, :text 
 
      def handle
        @response = Twilio::TwiML::Response.new do |r|
          r.Say 'Please record your message after the tone. Go Stella Dot!'
          r.Record :maxLength => '30', :action => '/recordings/complete', :method => 'get'
          r.Say 'Goodbye.'
        end

        render :text => @response.text, :type => :builder, :layout => false
    
      end
  
      def complete
    
        @recording = Recording.new(:tag => "A test message", :url => params["RecordingUrl"], :user_id => 1, :client_id => 1)
        @recording.save
    
        redirect_to action: 'index'
    
      end
  
  
    end
end

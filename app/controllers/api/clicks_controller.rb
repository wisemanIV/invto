module Api
  class ClicksController < ApplicationController
    skip_authorization_check
  
    respond_to :html

    def create
      
      @shareable = Shareable.where(:short => params[:short]).first
      @client_id = @shareable.client_id
      @client = Client.find(@client_id)
  
      if iphone_device? || ipad_device?
        device = 'iphone'
        targeturl = @client.ios_scheme
        defaulturl = @client.default_ios_url
      else if android_device?
        device = 'android'
        targeturl = @client.android_scheme
        defaulturl = @client.default_android_url
      else  
        device = 'other'
        targeturl = @client.default_url
        defaulturl = @client.default_url
      end
      end
      
      @click = Click.new(:shareable_id => @shareable.id, :actualurl => 'not set', :device => device, :targeturl => "http://www.apple.com", :defaulturl => @client.defaulturl, :user_agent => request.user_agent, :client_id => @client_id)
      @click.save
      
      respond_to do |format|
      if @click.save
        format.html { render 'response' }
      end
    end
  
    end

    def default
  
      @click = Click.find(params[:id])
  
      @click.actualurl = 'default'
  
      respond_to do |format|
        if @click.save 
          format.json { head :no_content }
        else
          format.json { render json: @click.errors, status: :unprocessable_entity }
        end
      end
    end
  end

end

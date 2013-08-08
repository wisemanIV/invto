module Api
  class ClicksController < ApplicationController
    skip_authorization_check
  
    respond_to :html

    def create
      
      puts "#{request.user_agent}"
  
      if iphone_device? 
        device = 'iphone'
      else
        if ipad_device?
          device = 'ipad'
        else
          device = 'other'
        end
      end
      
      puts "#{device}"
      
      @shareable = Shareable.where(:short => params[:short]).first
      @client_id = @shareable.client_id
      @client = Client.find(@client_id)
      puts "#{@shareable.id} #{@client.urlscheme} #{@client.defaulturl}"
      @click = Click.new(:shareable_id => @shareable.id, :actualurl => 'not set', :device => device, :targeturl => "http://www.apple.com", :defaulturl => @client.defaulturl, :client_id => @client_id)
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

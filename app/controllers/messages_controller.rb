require 'twilio-ruby'

class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.json
  def create
    
    account_sid = ENV["TWILIO_SID"]
    auth_token = ENV["TWILIO_TOKEN"]
    
    @client = Twilio::REST::Client.new account_sid, auth_token
  
    from = "+16198221406"
    # send an sms
    saved = true
    
    if params[:message][:body].blank? and !params[:message][:template].blank? then
      body = EmailTemplate.where("name = :template", { :template => params[:message][:template]}).first.body
      if !params[:message][:toname].blank? then
        body = body.sub("<toname>", params[:message][:toname])
      end
    else
      body = params[:message][:body]
    end
    
    friends = params[:message][:to].split(/,/)
    friends.each do |value|
      @message = Message.new(:to => value, :from => from, :body => body, :ref => params[:message][:ref] )
      @client.account.sms.messages.create(
        :from => @message.from,
        :to => @message.to,
        :body => @message.body
      )
      if !@message.save
        saved = false
        break ;
      end
    end

      respond_to do |format|
        if saved
          format.html { redirect_to @message, notice: 'Message was successfully created.' }
          format.json { render json: @message, status: :created, location: @message }
        else
          format.html { render action: "new" }
          format.json { render json: @message.errors, status: :unprocessable_entity }
        end
      end
    
 
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end
end

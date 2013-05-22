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
    
    account_sid = 'ACb9bd66cc869ba15ab6d19f6cf54bc4d4'
    auth_token = 'eb2b3afe288a18340fa8e60eb7f105e1'
    
    @client = Twilio::REST::Client.new account_sid, auth_token
  
    from = "+14159929816"
    # send an sms
    saved = true
    
    friends = params[:message][:to].split(/,/)
    friends.each do |value|
      @message = Message.new(:to => value, :from => from, :body => params[:message][:body], :ref => params[:message][:ref] )
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

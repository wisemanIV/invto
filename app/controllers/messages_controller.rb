class MessagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  respond_to :json, :html, :csv
    
  # GET /messages
  # GET /messages.json
  def index
    
    @userid = current_user.id
 #   @links_grid = initialize_grid(Message.where(:client_id => current_user.client_id), enable_export_to_csv: true)
     @links_grid = initialize_grid(Message.where(:client_id => current_user.client_id))
      
  #export_grid_if_requested(:grid => 'messages_grid') do
      
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
#  end
    
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
    
    client = Client.find(current_user.client_id)

    if client.nil? 
      respond_to do |format|
        format.html { redirect_to action: "index", notice: 'Cannot create SMS until an application is provisioned on your account.' }
      end
    else
    
    message = Message.new(params[:message])

    # send an sms
    saved = true
    
    if message[:body].blank? and !message[:template].blank? then
      body = EmailTemplate.where("name = :template", { :template => message[:template]}).first.body
      if !message[:toname].blank? then
        body = body.sub("<toname>", message[:toname])
      end
    else
      body = message[:body]
    end
    
    recipients = Message.get_message_array(message[:to])
    
    recipients.each do |value|
      
      if Message.is_valid_phone(value)
        status = "submitted"
      else 
        status = "invalid phone"
      end
      
      @message = Message.new(:campaign => message[:campaign], :version => message[:version], :to => value, :body => body, :status => status, :user_id => current_user.id, :client_id => client.id )
      
      if !@message.save
        saved = false
        break ;
      else
        @message.delay.send_sms!
      end
    end

      respond_to do |format|
        if saved
          format.html { redirect_to action: "index", notice: 'Message was successfully created.' }
          format.json { render json: @message, status: :created, location: @message }
        else
          format.html { render action: "new" }
          format.json { render json: @message.errors, status: :unprocessable_entity }
        end
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

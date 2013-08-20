class MessagesController < ApplicationController
  before_filter :authenticate_user!
  skip_authorization_check

  respond_to :html, :csv
  
  # GET /messages
  # GET /messages.json
  def index
  
    @userid = current_user.id
 #   @links_grid = initialize_grid(Message.where(:client_id => current_user.client_id), enable_export_to_csv: true)
 
     @links_grid = initialize_grid(Message.where(:client_id => current_user.client_id).order("created_at DESC"))
    
  #export_grid_if_requested(:grid => 'messages_grid') do
    
    respond_to do |format|
      format.html # index.html.erb
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
    @message.attachment = Attachment.new

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
  
    recipients = Message.get_message_array(params[:message][:to])
    @attachment = Attachment.create(params[:message][:attachment_attributes])

    @saved = true ;
   
    recipients.each do |value|
      
      if (Message.is_valid_phone(value))
        status = $MESSAGE_STATUS[1] #submitted
      else
        status = $MESSAGE_STATUS[7] #invalid phone
      end
      
      @message = Message.new(:campaign => params[:message][:campaign], :version => params[:message][:version], :to => value, :body => params[:message][:body], :status => status, :user_id => current_user.id, :client_id => client.id )
      @message.attachment = @attachment
     
      if !@message.save
        @saved = false
        break ;
      else
        @message.delay.send_sms!
      end
    end

      respond_to do |format|
        if @saved
          format.html { redirect_to action: "index", notice: 'Message was successfully created.' }
        else
          format.html { render action: "new" }
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
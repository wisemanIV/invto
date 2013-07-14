class MessagesController < ApplicationController
  before_filter :authenticate_user!
    
  # GET /messages
  # GET /messages.json
  def index
    
    @userid = current_user.id
    @links_grid = initialize_grid(Message.where(:user_id => @userid))
      
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
    
    message = Message.new(params[:message])
  
    from = ENV["TWILIO_FROM"]
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
    
    recipients = message[:to].split(/,/)
    recipients.each do |value|
      @message = Message.new(:campaign => message[:campaign], :version => message[:version], :to => value, :from => from, :body => body, :status => "processing", :user_id => current_user.id )
      
      if !@message.save
        saved = false
        break ;
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

require 'twilio-ruby'

class RecordingsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  respond_to :html
  
  def new

    account_sid = ENV["TWILIO_SID"]
    auth_token = ENV["TWILIO_TOKEN"]
    app_sid = ENV["TWILIO_APP_SID"]

     capability = Twilio::Util::Capability.new account_sid, auth_token
     capability.allow_client_outgoing app_sid
     token = capability.generate

     render partial: "record", locals: { :token => token} 
  end
  
  # GET /recordings
  # GET /recordings.json
  def index
    @user = User.find(current_user.id)
    
    @links_grid = initialize_grid(Recording.where(:client_id => @user.client_id))

    respond_to do |format|
      format.html # index.html.erb
    end
    
  end

  # GET /recordings/1
  # GET /recordings/1.json
  def show
    @recording = Recording.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  

  # GET /recordings/1/edit
  def edit
    @recording = Recording.find(params[:id])
  end

  def create
    @recording = Recording.new(params[:recording])

    respond_to do |format|
      if @recording.save
        format.html { redirect_to @recording, notice: 'Recording was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /recordings/1
  # PUT /recordings/1.json
  def update
    @recording = Recording.find(params[:id])

    respond_to do |format|
      if @recording.update_attributes(params[:recording])
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /recordings/1
  # DELETE /recordings/1.json
  def destroy
    @recording = Recording.find(params[:id])
    @recording.destroy

    respond_to do |format|
      format.html { redirect_to recordings_url }
    end
  end
end

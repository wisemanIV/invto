require 'twilio-ruby'

class RecordingsController < ApplicationController
   skip_authorization_check
   
   respond_to :html, :xml
  
  def new
    
    account_sid = ENV["TWILIO_SID"]
    auth_token = ENV["TWILIO_TOKEN"]
    app_sid = 'APdd5281a9c04e260490de6f5efefb09f6'
    
     capability = Twilio::Util::Capability.new account_sid, auth_token
     capability.allow_client_outgoing app_sid
     token = capability.generate
    
     render partial: "record", locals: { :token => token} 
  end
 
 
  def handle
    @response = Twilio::TwiML::Response.new do |r|
      r.Say 'Listen to your monkey howl.'
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
  
  
  # GET /recordings
  # GET /recordings.json
  def index
    @recordings = Recording.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recordings }
    end
  end

  # GET /recordings/1
  # GET /recordings/1.json
  def show
    @recording = Recording.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recording }
    end
  end

  

  # GET /recordings/1/edit
  def edit
    @recording = Recording.find(params[:id])
  end

  # POST /recordings
  # POST /recordings.json
  def create
    @recording = Recording.new(params[:recording])

    respond_to do |format|
      if @recording.save
        format.html { redirect_to @recording, notice: 'Recording was successfully created.' }
        format.json { render json: @recording, status: :created, location: @recording }
      else
        format.html { render action: "new" }
        format.json { render json: @recording.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recordings/1
  # PUT /recordings/1.json
  def update
    @recording = Recording.find(params[:id])

    respond_to do |format|
      if @recording.update_attributes(params[:recording])
        format.html { redirect_to @recording, notice: 'Recording was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recording.errors, status: :unprocessable_entity }
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
      format.json { head :no_content }
    end
  end
end

class SmsResponsesController < ApplicationController
  before_filter :authenticate_user!
   load_and_authorize_resource
  # GET /sms_responses
  # GET /sms_responses.json
  def index
    
    @user = User.find(current_user.id)
    
    @links_grid = initialize_grid(SmsResponse.where(:client_id => @user.client_id))

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sms_responses }
    end
  end

  # GET /sms_responses/1
  # GET /sms_responses/1.json
  def show
    @sms_response = SmsResponse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sms_response }
    end
  end

  # GET /sms_responses/new
  # GET /sms_responses/new.json
  def new
    @sms_response = SmsResponse.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sms_response }
    end
  end

  # GET /sms_responses/1/edit
  def edit
    @sms_response = SmsResponse.find(params[:id])
  end

  # POST /sms_responses
  # POST /sms_responses.json
  def create
    @sms_response = SmsResponse.new(params[:sms_response])

    respond_to do |format|
      if @sms_response.save
        format.html { redirect_to @sms_response, notice: 'Sms response was successfully created.' }
        format.json { render json: @sms_response, status: :created, location: @sms_response }
      else
        format.html { render action: "new" }
        format.json { render json: @sms_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sms_responses/1
  # PUT /sms_responses/1.json
  def update
    @sms_response = SmsResponse.find(params[:id])

    respond_to do |format|
      if @sms_response.update_attributes(params[:sms_response])
        format.html { redirect_to @sms_response, notice: 'Sms response was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sms_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sms_responses/1
  # DELETE /sms_responses/1.json
  def destroy
    @sms_response = SmsResponse.find(params[:id])
    @sms_response.destroy

    respond_to do |format|
      format.html { redirect_to sms_responses_url }
      format.json { head :no_content }
    end
  end
end

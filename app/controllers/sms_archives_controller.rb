class SmsArchivesController < ApplicationController
  # GET /sms_archives
  # GET /sms_archives.json
  def index
    @sms_archives = SmsArchive.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sms_archives }
    end
  end

  # GET /sms_archives/1
  # GET /sms_archives/1.json
  def show
    @sms_archive = SmsArchive.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sms_archive }
    end
  end

  # GET /sms_archives/new
  # GET /sms_archives/new.json
  def new
    @sms_archive = SmsArchive.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sms_archive }
    end
  end

  # GET /sms_archives/1/edit
  def edit
    @sms_archive = SmsArchive.find(params[:id])
  end

  # POST /sms_archives
  # POST /sms_archives.json
  def create
    @sms_archive = SmsArchive.new(params[:sms_archive])

    respond_to do |format|
      if @sms_archive.save
        format.html { redirect_to @sms_archive, notice: 'Sms archive was successfully created.' }
        format.json { render json: @sms_archive, status: :created, location: @sms_archive }
      else
        format.html { render action: "new" }
        format.json { render json: @sms_archive.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sms_archives/1
  # PUT /sms_archives/1.json
  def update
    @sms_archive = SmsArchive.find(params[:id])

    respond_to do |format|
      if @sms_archive.update_attributes(params[:sms_archive])
        format.html { redirect_to @sms_archive, notice: 'Sms archive was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sms_archive.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sms_archives/1
  # DELETE /sms_archives/1.json
  def destroy
    @sms_archive = SmsArchive.find(params[:id])
    @sms_archive.destroy

    respond_to do |format|
      format.html { redirect_to sms_archives_url }
      format.json { head :no_content }
    end
  end
end

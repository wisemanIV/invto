class ClientNumbersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  # GET /client_numbers
  # GET /client_numbers.json
  def index
    @client_numbers = ClientNumber.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @client_numbers }
    end
  end

  # GET /client_numbers/1
  # GET /client_numbers/1.json
  def show
    @client_number = ClientNumber.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client_number }
    end
  end

  # GET /client_numbers/new
  # GET /client_numbers/new.json
  def new
    @client_number = ClientNumber.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client_number }
    end
  end

  # GET /client_numbers/1/edit
  def edit
    @client_number = ClientNumber.find(params[:id])
  end

  # POST /client_numbers
  # POST /client_numbers.json
  def create
    @client_number = ClientNumber.new(params[:client_number])

    respond_to do |format|
      if @client_number.save
        format.html { redirect_to @client_number, notice: 'Client number was successfully created.' }
        format.json { render json: @client_number, status: :created, location: @client_number }
      else
        format.html { render action: "new" }
        format.json { render json: @client_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /client_numbers/1
  # PUT /client_numbers/1.json
  def update
    @client_number = ClientNumber.find(params[:id])

    respond_to do |format|
      if @client_number.update_attributes(params[:client_number])
        format.html { redirect_to @client_number, notice: 'Client number was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_numbers/1
  # DELETE /client_numbers/1.json
  def destroy
    @client_number = ClientNumber.find(params[:id])
    @client_number.destroy

    respond_to do |format|
      format.html { redirect_to client_numbers_url }
      format.json { head :no_content }
    end
  end
end

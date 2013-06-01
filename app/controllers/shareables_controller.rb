class ShareablesController < ApplicationController
  before_filter :authenticate_user!
    
  # GET /shareables
  # GET /shareables.json
  def index
    @shareables = Shareable.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shareables }
    end
  end

  # GET /shareables/1
  # GET /shareables/1.json
  def show
    @shareable = Shareable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shareable }
    end
  end

  # GET /shareables/new
  # GET /shareables/new.json
  def new
    @shareable = Shareable.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shareable }
    end
  end

  # GET /shareables/1/edit
  def edit
    @shareable = Shareable.find(params[:id])
  end

  # POST /shareables
  # POST /shareables.json
  def create
    @shareable = Shareable.new(params[:shareable])

    respond_to do |format|
      if @shareable.save
        @shareable.shareable = Shareable.encode(@shareable.id)
        @shareable.save
        format.html { redirect_to @shareable, notice: 'Shareable was successfully created.' }
        format.json { render json: @shareable, status: :created, location: @shareable }
      else
        format.html { render action: "new" }
        format.json { render json: @shareable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shareables/1
  # PUT /shareables/1.json
  def update
    @shareable = Shareable.find(params[:id])

    respond_to do |format|
      if @shareable.update_attributes(params[:shareable])
        format.html { redirect_to @shareable, notice: 'Shareable was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @shareable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shareables/1
  # DELETE /shareables/1.json
  def destroy
    @shareable = Shareable.find(params[:id])
    @shareable.destroy

    respond_to do |format|
      format.html { redirect_to shareables_url }
      format.json { head :no_content }
    end
  end
end

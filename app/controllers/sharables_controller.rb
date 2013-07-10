class SharablesController < ApplicationController
  # GET /sharables
  # GET /sharables.json
  def index
    @sharables = Sharable.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sharables }
    end
  end

  # GET /sharables/1
  # GET /sharables/1.json
  def show
    @sharable = Sharable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sharable }
    end
  end

  # GET /sharables/new
  # GET /sharables/new.json
  def new
    @sharable = Sharable.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sharable }
    end
  end

  # GET /sharables/1/edit
  def edit
    @sharable = Sharable.find(params[:id])
  end

  # POST /sharables
  # POST /sharables.json
  def create
    @sharable = Sharable.new(params[:sharable])
    
    

    respond_to do |format|
      if @sharable.save
        format.html { redirect_to @sharable, notice: 'Sharable was successfully created.' }
        format.json { render json: @sharable, status: :created, location: @sharable }
      else
        format.html { render action: "new" }
        format.json { render json: @sharable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sharables/1
  # PUT /sharables/1.json
  def update
    @sharable = Sharable.find(params[:id])

    respond_to do |format|
      if @sharable.update_attributes(params[:sharable])
        format.html { redirect_to @sharable, notice: 'Sharable was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sharable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sharables/1
  # DELETE /sharables/1.json
  def destroy
    @sharable = Sharable.find(params[:id])
    @sharable.destroy

    respond_to do |format|
      format.html { redirect_to sharables_url }
      format.json { head :no_content }
    end
  end
end

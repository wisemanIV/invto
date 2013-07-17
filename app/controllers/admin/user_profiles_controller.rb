class Admin::UserProfilesController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /user_profiles
  # GET /user_profiles.json
  def index
    
    @links_grid = initialize_grid(User)
    authorize! :manage, User
    
    respond_to do |format|
      format.html 
      format.json { render json: @user }
    end
  end
  
  # GET /emails/1/edit
  def edit
    @user = User.find(params[:id])
    authorize! :manage, User
  end
  
  # PUT /recipients/1
  # PUT /recipients/1.json
  def update
    
    @user = User.find(params[:id])
    authorize! :manage, User

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to :controller=>'admin/user_profiles', :action => 'index' }
        format.json { head :no_content }
      else
        format.html 
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /recipients/1
  # DELETE /recipients/1.json
  def destroy
    @user = User.find(params[:id])
    authorize! :manage, User
    @user.destroy

    respond_to do |format|
      format.html { redirect_to :controller=>'admin/user_profiles', :action => 'index' }
      format.json { head :no_content }
    end
  end

end

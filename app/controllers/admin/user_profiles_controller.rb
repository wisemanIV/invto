class Admin::UserProfilesController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /user_profiles
  # GET /user_profiles.json
  def index
    
    @links_grid = initialize_grid(User)
    authorize! :read, User
    respond_to do |format|
      format.html 
      format.json { render json: @user }
    end
  end

  # DELETE /user/1
  # DELETE /user/1.json
  def destroy
    @user = User.find(params[:id])
    user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end

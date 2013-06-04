class UserProfileController < ApplicationController
  
  # GET /user_profiles/1
  # GET /user_profiles/1.json
  def index
    @user = User.find(current_user.id)

    respond_to do |format|
      format.html { render action: "show" }
      format.json { render json: @user }
    end
  end
  
  
end

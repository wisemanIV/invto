require 'test_helper'
#require 'carrierwave/test/matchers'
 
class RecipientsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  # called before every single test
  setup :initialize_test
  
  test "is user saved" do
    refute_nil(@savedUser)
  end
  
  test "recipients index" do
    get :index
    assert_response :success
  end
  
 
  def initialize_test
   
    @user = FactoryGirl.create(:user)
    
    @savedUser = User.where(:authentication_token => @user.authentication_token).first
   
    sign_in User.first
  end
  
end
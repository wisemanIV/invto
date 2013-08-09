require 'test_helper'
 
class Api::V1::ShareablesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  # called before every single test
  setup :initialize_test
  
  test "is user saved" do
    refute_nil(@user)
  end

  test "should create api shareable" do
    set_request_headers
    post :create, { :shareable => @shareable_params }
    assert_response :success
  end
  
  def set_request_headers
    @request.env["HTTP_ACCEPT"] = "application/json, application/vnd.inviter.v1"
    @request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(@user.authentication_token)
  end
  
  def initialize_test
    @client = FactoryGirl.create(:client)
    @user = FactoryGirl.create(:user, :client_id => @client.id)
    @client_number = FactoryGirl.create(:client_number, :client_id => @client.id)
    @shareable = FactoryGirl.create(:shareable, :client_id => @client.id)
    @shareable_params = FactoryGirl.attributes_for(:shareable, :client_id => @client.id)
  
  end

end
  
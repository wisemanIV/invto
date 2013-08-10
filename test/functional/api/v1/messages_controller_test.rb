require 'test_helper'
 
class Api::V1::MessagesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  # called before every single test
  setup :initialize_test
  
  test "is user saved" do
    refute_nil(@user)
  end

  test "should create api message" do
    set_request_headers
    post :create, { :message => @message_params }
    assert_response :success
  end
  
  test "should get api message index" do
    set_request_headers
    get :index
    assert_response :success
    assert_not_nil assigns(:messages)
  end
  
  def set_request_headers
    @request.env["HTTP_ACCEPT"] = "application/json, application/vnd.inviter.v1"
    @request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(@user.authentication_token)
  end
  
  def initialize_test
    @client = FactoryGirl.create(:client)
    @user = FactoryGirl.create(:user, :client_id => @client.id)
    @client_number = FactoryGirl.create(:client_number, :client_id => @client.id)
    @message = FactoryGirl.create(:message, :client_id => @client.id, :user_id => 1)
    @message_params = FactoryGirl.attributes_for(:message, :client_id => @client.id, :user_id => 1)
  
  end

end
  
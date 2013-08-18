require 'test_helper'
#require 'carrierwave/test/matchers'
 
class MessagesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  # called before every single test
  setup :initialize_test
  
  test "is user saved" do
    refute_nil(@savedUser)
  end
  
  test "messages index" do
    get :index
    assert_response :success
  end
  
  test "messages create" do
    @message_params = FactoryGirl.attributes_for(:message, :SmsId => nil)
    
    sign_in @user
    assert_difference ->{ Message.count }, 1 do
      post :create, :message => @message_params, session
      assert_response :success
    end
  end
  
  test "messages create multiple" do
    @message_params = FactoryGirl.attributes_for(:message, :SmsId => nil, :to => "+14154200068, (415) 420 0068")
    
    sign_in @user
    assert_difference ->{ Message.count }, 2 do
      post :create, :message => @message_params, session
      assert_response :success
    end
  end
  
 
  def initialize_test
   
    @client = FactoryGirl.create(:client)
    @user = FactoryGirl.create(:user, :role => "admin", :client_id => @client.id)
    
    @savedUser = User.where(:authentication_token => @user.authentication_token).first
   
    sign_in :user, @user
  end
  
end
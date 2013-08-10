require 'test_helper'
 
class Api::CallbackControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  # called before every single test
  setup :initialize_test

  test "test mogreet response" do
      post :handle_mogreet_response, {"mogreet"=>{"event"=>"message-in", "campaign_id"=>"45817", "msisdn"=>"14154200068", "carrier"=>"Sprint", "message"=>"STELLADOT hello", "callback"=>{"event"=>"message-in", "campaign_id"=>"45817", "msisdn"=>"14154200068", "carrier"=>"Sprint", "message"=>"STELLADOT hello"}}}
      assert_response :success
  end
  
  test "test mogreet callback" do
      post :mogreet_callback, {"response"=>{"status"=>"success", "messages_id"=> @message.SmsId, "campaign_id"=>"45817", "msisdn"=>"14154200068", "message"=>"STELLADOT hello"}}
      assert_response :success
  end
  
  test "test twilio callback" do
      post :twilio_callback, {"SmsStatus"=>"sent"}
      assert_response :success
  end
  
  test "test twilio response" do
      post :twilio_callback, {"SmsStatus"=>"received"}
      assert_response :success
  end

  
  def initialize_test
    @client = FactoryGirl.create(:client)
    @shareable = FactoryGirl.build(:shareable, :client_id => 1)
    @shareable.save!
    @shareable.shorten!
    @click = FactoryGirl.create(:click, :client_id => @client.id, :shareable_id => @shareable.id)
    @click_params = FactoryGirl.attributes_for(:click, :client_id => @client.id, :shareable_id => @shareable.id)
    @message = FactoryGirl.create(:message, :client_id => @client.id, :user_id => 1)
   end

end
  
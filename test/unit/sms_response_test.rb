require 'test_helper'

class SmsResponseTest < ActiveSupport::TestCase
  
  setup :initialize_test
  
  test "opt out request" do 
    assert SmsResponse.opt_out_request("Stop")
    assert SmsResponse.opt_out_request("STOP")
    assert SmsResponse.opt_out_request("stop")
    assert SmsResponse.opt_out_request("Cancel")
    assert SmsResponse.opt_out_request("CANCEL")
    assert SmsResponse.opt_out_request("cancel")
    assert SmsResponse.opt_out_request("Quit")
    assert SmsResponse.opt_out_request("QUIT")
    assert SmsResponse.opt_out_request("quit")
    assert SmsResponse.opt_out_request("UNSUBSCRIBE")
    assert SmsResponse.opt_out_request("Unsubscribe")
    assert SmsResponse.opt_out_request("unsubscribe")
    assert SmsResponse.opt_out_request("please sTOp")
    assert SmsResponse.opt_out_request("i quiT!!!")
    assert SmsResponse.opt_out_request("stop it!!")
    assert SmsResponse.opt_out_request("can you unsubscribe me?!")
  end
  
  test "handle sms response twilio" do
     assert_difference ->{ SmsResponse.count }, 1 do
       SmsResponse.handle_twilio_response("TWILIO", @message.SmsId, "345", @client_number.phone, @message.from, @message.body, "SAN FRANCISCO", "CA", "94010", "US")
     end
  end
  
  test "handle sms response mogreet" do
    
    assert_difference ->{ SmsResponse.count }, 1 do
      SmsResponse.handle_mogreet_response("MOGREET", @client.mogreet_campaign_id, @message.SmsId, @message.from, @message.to, @message.body, "https://www.google.com/images/srpr/logo4w.png")
    end
    @sms_response = SmsResponse.order('created_at desc').first
    assert !@sms_response.attachment_url.blank?
  end
  
  def initialize_test
    @client = FactoryGirl.create(:client)
    @client_number = FactoryGirl.create(:client_number, :client_id => @client.id)
  
    @message = FactoryGirl.create(:message, :client_id => @client.id, :user_id => 1, :SmsId => 23)  
    @sms_response = FactoryGirl.create(:sms_response, :client_id => @client.id)
    @sms_response_opt_out = FactoryGirl.create(:sms_response, :client_id => @client.id, :Body => "Stop")
  end
end

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
  
  def initialize_test
    @client = FactoryGirl.create(:client)
    @client_number = FactoryGirl.create(:client_number, :client_id => @client.id)
    
    @sms_response = FactoryGirl.create(:sms_response, :client_id => @client.id)
    
    @sms_response_opt_out = FactoryGirl.create(:sms_response, :client_id => @client.id, :Body => "Stop")
  end
end

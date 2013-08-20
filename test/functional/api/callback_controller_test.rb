require 'test_helper'
 
class Api::CallbackControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  # called before every single test
  setup :initialize_test

  test "test mogreet response" do
    assert_difference ->{ SmsResponse.count }, 1 do
      post :handle_mogreet_response, {"event"=>"message-in", "campaign_id"=>@client.mogreet_campaign_id.to_i, "msisdn"=>"14154200068", "carrier"=>"Sprint", "message"=>"STELLADOT hello",  "images"=>{"image"=>"http://d2c.bandcon.mogreet.com/mo-mms/images/623452_4302951.jpeg"}}
      assert_response :success
    end
  end
  
  test "test mogreet y body" do
    phone = Message.clean_phone_number(Faker::PhoneNumber.cell_phone)
    assert_difference ->{ SmsResponse.count }, 0 do
      assert_difference ->{ Recipient.count }, 1 do
        post :handle_mogreet_response, {"event"=>"message-in", "campaign_id"=>@client.mogreet_campaign_id.to_i, "msisdn"=>phone, "carrier"=>"Sprint", "message"=>"y"}
        assert_response :success
      end
    end
    response = Recipient.where(:Phone => Message.less_country_code(phone)).first
    assert_equal response.OptOut,false
    
  end
  
  test "test mogreet opt in" do
    phone = Message.clean_phone_number(Faker::PhoneNumber.cell_phone)
    assert_difference ->{ SmsResponse.count }, 0 do
      assert_difference ->{ Recipient.count }, 1 do
        post :handle_mogreet_response, {"event"=>"reply-y", "campaign_id"=>@client.mogreet_campaign_id.to_i, "msisdn"=>phone, "carrier"=>"Sprint", "message"=>"y"}
        assert_response :success
        end
      end
    response = Recipient.where(:Phone => Message.less_country_code(phone)).first
    assert_equal response.OptOut,false
    
  end
  
  test "test mogreet opt out" do
    phone = Message.clean_phone_number(Faker::PhoneNumber.cell_phone)
    assert_difference ->{ SmsResponse.count }, 0 do
      assert_difference ->{ Recipient.count }, 1 do
        post :handle_mogreet_response, {"event"=>"stop", "campaign_id"=>@client.mogreet_campaign_id.to_i, "msisdn"=>phone, "carrier"=>"Sprint", "message"=>"Please STOP"}
        assert_response :success
      end
    end
    response = Recipient.where(:Phone => Message.less_country_code(phone)).first
    assert_equal response.OptOut,true
    
  end
  
  test "test mogreet callback" do
      post :mogreet_callback, {"response"=>{"status"=>"success", "message_id"=> @message.SmsId, "campaign_id"=>"45817", "msisdn"=>"14154200068", "message"=>"STELLADOT hello"}}
      assert_response :success
      @message = Message.find(@message.id)
      assert_equal $MESSAGE_STATUS[4], @message.status
  end
  
  test "test twilio callback" do
      post :twilio_callback, {"SmsStatus"=>"sent", "SmsSid"=>@message.SmsId}
      assert_response :success
      @message = Message.find(@message.id)
      assert_equal $MESSAGE_STATUS[4], @message.status
  end
  
  test "test twilio response" do
     assert_difference ->{ SmsResponse.count }, 1 do
      post :twilio_callback, {"SmsStatus"=>"received", "To"=>@client_number.phone}
      assert_response :success
    end
  end

  
  def initialize_test
    @client = FactoryGirl.create(:client)
    @client_number = FactoryGirl.create(:client_number, :client_id => @client.id)
    @shareable = FactoryGirl.build(:shareable, :client_id => 1)
    @shareable.save!
    @shareable.shorten!
    @click = FactoryGirl.create(:click, :client_id => @client.id, :shareable_id => @shareable.id)
    @click_params = FactoryGirl.attributes_for(:click, :client_id => @client.id, :shareable_id => @shareable.id)
    @message = FactoryGirl.create(:message, :client_id => @client.id, :user_id => 1)
   end

end
  
require 'test_helper'
require 'twilio-ruby'

class MessageTest < ActiveSupport::TestCase
  
  setup :initialize_test
  
  test "archive test" do
    @message.status = $MESSAGE_STATUS[4] #sent
    @message.save!
    assert Message.count == 1
    assert SmsArchive.count == 0
    Message.archive
    assert Message.count == 0 
    assert SmsArchive.count == 1
  end
  
  test "send twilio" do
    @message.status = $MESSAGE_STATUS[1] #submitted
    @message.save! 
 #   @message.send_twilio
 #   assert_equal @message.status, $MESSAGE_STATUS[3]
  end
  
  test "twilio error" do
    @message.status = $MESSAGE_STATUS[1] #submitted
    @message.save! 
    @message.to = "123"
    assert_raise Twilio::REST::RequestError  do
      @message.send_twilio
    end
    assert_equal @message.status, $MESSAGE_STATUS[8]
  end
  
  test "handle sms sent" do
    @message.status = $MESSAGE_STATUS[3] #awaiting response
    Message.handle_sms_sent(@message.SmsId)
    @message = Message.find(@message.id)
    assert_equal @message.status, $MESSAGE_STATUS[4] #sent
  end
  
  test "handle sms error" do
    @message.status = $MESSAGE_STATUS[3] #awaiting response
    Message.handle_sms_error("MOGREET", @message.SmsId, "603", "an error")
    @message = Message.find(@message.id)
    assert_equal @message.status, $MESSAGE_STATUS[5] #error
    assert_equal @message.response_code, "603"
    assert_equal @message.response, "an error"
  end
  
  test "is valid phone" do 
    assert Message.is_valid_phone('4154200068')
    assert Message.is_valid_phone('14154200068')
    assert Message.is_valid_phone('+14154200068')
    assert !Message.is_valid_phone('0154200068')
    assert !Message.is_valid_phone('72154200068')
    assert !Message.is_valid_phone('472154200068')
    assert !Message.is_valid_phone('470068')
  end
  
  test "clean phone number" do 
    assert_equal Message.clean_phone_number('+1 (415) 420 0068'), "+14154200068"
    assert_equal Message.clean_phone_number('415-420-0068'), "4154200068"
    assert_equal Message.clean_phone_number('+1 4154200068'), "+14154200068"
    assert_equal Message.clean_phone_number('415-[420] 0068'), "4154200068"
    assert_equal Message.clean_phone_number('+1 415.420.0068'), "+14154200068"
    assert_equal Message.clean_phone_number('415.420.0 0 6 8'), "4154200068"
    assert_equal Message.clean_phone_number('#415 420*0068'), "4154200068"
    assert_equal Message.clean_phone_number(' +1415420-0068 '), "+14154200068"
  end
  
  test "get country code" do 
    assert_equal Message.get_country_code('4154200068'), "+1"
    assert_equal Message.get_country_code('+444154200068'), "+4"
    assert_equal Message.get_country_code('+14154200068'), "+1"
  end
  
  test "less country code" do 
    assert_equal Message.less_country_code('+14154200068'), "4154200068"
    assert_equal Message.less_country_code('4154200068'), "4154200068"
    assert_equal Message.less_country_code('+444154200068'), "44154200068"
  end
  
  test "xml" do
    doc = Nokogiri::XML::Document.parse('<?xml version="1.0"?><response code="1" status="success"><message><![CDATA[QUEUED]]></message\><message_id>263327880</message_id><hash>ibkes16u</hash\></response>')

    assert !doc.xpath('//@status').blank? 
    assert_equal doc.xpath('//@status').inner_text, 'success'
    assert !doc.xpath('//message_id').blank? 
    assert_equal doc.xpath('//message_id').inner_text, '263327880'
    
  end
  
  def initialize_test
    @client = FactoryGirl.create(:client)
    @client_number = FactoryGirl.create(:client_number, :client_id => @client.id)
    @message = FactoryGirl.create(:message, :client_id => @client.id, :user_id => 1)
  end
end
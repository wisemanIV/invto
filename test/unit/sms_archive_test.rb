require 'test_helper'

class SmsArchiveTest < ActiveSupport::TestCase
  
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
  
  def initialize_test
    @client = FactoryGirl.create(:client)
    @client_number = FactoryGirl.create(:client_number, :client_id => @client.id)
    @message = FactoryGirl.create(:message, :client_id => @client.id, :user_id => 1)
  end
  
end

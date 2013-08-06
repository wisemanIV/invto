require 'test_helper'

class RecordingTest < ActiveSupport::TestCase
  setup :initialize_test
  
  test "test recording attributes" do 
    assert_equal @recording.url, "http://www.inv.to/3434343asass3/334343434.mp3"
    assert_equal @recording.tag, "A new messages for you"
  end
    
  def initialize_test 
    @recording = FactoryGirl.create(:recording, :user_id => 1, :client_id => 1)
  end
end

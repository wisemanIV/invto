require 'test_helper'

class RecipientTest < ActiveSupport::TestCase
  
  setup :initialize_test
  
  test "test opted out" do 
    assert Recipient.opted_out?("4154200068")
  end
  
  def initialize_test
    @client = FactoryGirl.create(:client)
    @recipient = FactoryGirl.create(:recipient, :Phone => "4154200068", :client_id => @client.id)
  end
end

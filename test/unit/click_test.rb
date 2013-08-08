require 'test_helper'

class ClickTest < ActiveSupport::TestCase
  
  setup :initialize_test
  
  test "test click" do 
    
  end
    
  def initialize_test 
    @client = FactoryGirl.create(:client)
    @shareable = FactoryGirl.build(:shareable, :client_id => 1)
    @shareable.save!
    @shareable.shorten!
    @click = FactoryGirl.create(:click, :client_id => @client.id, :shareable_id => @shareable.id)
  end
 
end
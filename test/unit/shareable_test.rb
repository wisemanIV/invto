require 'test_helper'

class ShareableTest < ActiveSupport::TestCase
  
  setup :initialize_test
  
  test "shorten test" do
    @shareable.save!
    @shareable.shorten!
    assert @shareable.short =~ /\w{6}/
    assert !@shareable.shareable.nil?
  end
  
  test "shortener test" do 
    assert Shareable.encode(1) =~ /\w{6}/
    assert Shareable.encode(143) =~ /\w{6}/
    assert Shareable.encode(1324345454) =~ /\w{6}/
    assert Shareable.encode(787879) =~ /\w{6}/
    assert Shareable.encode(5555) =~ /\w{6}/
    
  end
  
  def initialize_test
    @shareable = FactoryGirl.build(:shareable, :client_id => 1)
  end
end

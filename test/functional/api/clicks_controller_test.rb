require 'test_helper'
 
class Api::ClicksControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  # called before every single test
  setup :initialize_test

  test "should create api click" do
  #  get '/'+@shareable.short
  #  assert_response :success
  end
  
  def initialize_test
    @client = FactoryGirl.create(:client)
    @shareable = FactoryGirl.build(:shareable, :client_id => 1)
    @shareable.save!
    @shareable.shorten!
    @click = FactoryGirl.create(:click, :client_id => @client.id, :shareable_id => @shareable.id)
    @click_params = FactoryGirl.attributes_for(:click, :client_id => @client.id, :shareable_id => @shareable.id)
  
  end

end
  
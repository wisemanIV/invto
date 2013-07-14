require 'test_helper'

class SmsResponsesControllerTest < ActionController::TestCase
  setup do
    @sms_response = sms_responses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sms_responses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sms_response" do
    assert_difference('SmsResponse.count') do
      post :create, sms_response: { AccountSid: @sms_response.AccountSid, Body: @sms_response.Body, From: @sms_response.From, FromCity: @sms_response.FromCity, FromCountry: @sms_response.FromCountry, FromState: @sms_response.FromState, FromZIP: @sms_response.FromZIP, SMSId: @sms_response.SMSId, To: @sms_response.To, ToCity: @sms_response.ToCity, ToCountry: @sms_response.ToCountry, ToState: @sms_response.ToState, ToZIP: @sms_response.ToZIP }
    end

    assert_redirected_to sms_response_path(assigns(:sms_response))
  end

  test "should show sms_response" do
    get :show, id: @sms_response
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sms_response
    assert_response :success
  end

  test "should update sms_response" do
    put :update, id: @sms_response, sms_response: { AccountSid: @sms_response.AccountSid, Body: @sms_response.Body, From: @sms_response.From, FromCity: @sms_response.FromCity, FromCountry: @sms_response.FromCountry, FromState: @sms_response.FromState, FromZIP: @sms_response.FromZIP, SMSId: @sms_response.SMSId, To: @sms_response.To, ToCity: @sms_response.ToCity, ToCountry: @sms_response.ToCountry, ToState: @sms_response.ToState, ToZIP: @sms_response.ToZIP }
    assert_redirected_to sms_response_path(assigns(:sms_response))
  end

  test "should destroy sms_response" do
    assert_difference('SmsResponse.count', -1) do
      delete :destroy, id: @sms_response
    end

    assert_redirected_to sms_responses_path
  end
end

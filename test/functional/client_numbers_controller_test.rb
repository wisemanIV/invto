require 'test_helper'

class ClientNumbersControllerTest < ActionController::TestCase
  setup do
    @client_number = client_numbers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:client_numbers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client_number" do
    assert_difference('ClientNumber.count') do
      post :create, client_number: { client_id: @client_number.client_id, phone: @client_number.phone }
    end

    assert_redirected_to client_number_path(assigns(:client_number))
  end

  test "should show client_number" do
    get :show, id: @client_number
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @client_number
    assert_response :success
  end

  test "should update client_number" do
    put :update, id: @client_number, client_number: { client_id: @client_number.client_id, phone: @client_number.phone }
    assert_redirected_to client_number_path(assigns(:client_number))
  end

  test "should destroy client_number" do
    assert_difference('ClientNumber.count', -1) do
      delete :destroy, id: @client_number
    end

    assert_redirected_to client_numbers_path
  end
end

require 'test_helper'

class UsersClientsControllerTest < ActionController::TestCase
  setup do
    @users_client = users_clients(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users_clients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create users_client" do
    assert_difference('UsersClient.count') do
      post :create, users_client: { client_id: @users_client.client_id, user_id: @users_client.user_id }
    end

    assert_redirected_to users_client_path(assigns(:users_client))
  end

  test "should show users_client" do
    get :show, id: @users_client
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @users_client
    assert_response :success
  end

  test "should update users_client" do
    put :update, id: @users_client, users_client: { client_id: @users_client.client_id, user_id: @users_client.user_id }
    assert_redirected_to users_client_path(assigns(:users_client))
  end

  test "should destroy users_client" do
    assert_difference('UsersClient.count', -1) do
      delete :destroy, id: @users_client
    end

    assert_redirected_to users_clients_path
  end
end

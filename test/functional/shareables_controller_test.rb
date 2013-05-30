require 'test_helper'

class ShareablesControllerTest < ActionController::TestCase
  setup do
    @shareable = shareables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shareables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shareable" do
    assert_difference('Shareable.count') do
      post :create, shareable: { client: @shareable.client, customer: @shareable.customer, input: @shareable.input, shareable: @shareable.shareable }
    end

    assert_redirected_to shareable_path(assigns(:shareable))
  end

  test "should show shareable" do
    get :show, id: @shareable
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shareable
    assert_response :success
  end

  test "should update shareable" do
    put :update, id: @shareable, shareable: { client: @shareable.client, customer: @shareable.customer, input: @shareable.input, shareable: @shareable.shareable }
    assert_redirected_to shareable_path(assigns(:shareable))
  end

  test "should destroy shareable" do
    assert_difference('Shareable.count', -1) do
      delete :destroy, id: @shareable
    end

    assert_redirected_to shareables_path
  end
end

require 'test_helper'

class CastingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get apply" do
    get :apply
    assert_response :success
  end

end

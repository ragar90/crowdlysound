require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get landing_page" do
    get :landing_page
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end

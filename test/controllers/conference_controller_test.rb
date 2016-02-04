require 'test_helper'

class ConferenceControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get registration" do
    get :registration
    assert_response :success
  end

  test "should get program" do
    get :program
    assert_response :success
  end

end

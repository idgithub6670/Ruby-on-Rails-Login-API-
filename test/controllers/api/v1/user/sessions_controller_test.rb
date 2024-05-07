require "test_helper"

class Api::V1::User::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get sign_in" do
    get api_v1_user_sessions_sign_in_url
    assert_response :success
  end

  test "should get sign_out" do
    get api_v1_user_sessions_sign_out_url
    assert_response :success
  end

  test "should get me" do
    get api_v1_user_sessions_me_url
    assert_response :success
  end
end

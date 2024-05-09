require "test_helper"

class UsersSignupControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_signup_new_url
    assert_response :success
  end

  test "should get create" do
    get users_signup_create_url
    assert_response :success
  end
end

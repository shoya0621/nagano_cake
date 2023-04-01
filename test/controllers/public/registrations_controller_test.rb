require "test_helper"

class Public::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get get" do
    get public_registrations_get_url
    assert_response :success
  end

  test "should get post" do
    get public_registrations_post_url
    assert_response :success
  end
end

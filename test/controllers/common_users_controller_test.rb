require 'test_helper'

class CommonUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get common_users_index_url
    assert_response :success
  end

  test "should get add" do
    get common_users_add_url
    assert_response :success
  end

  test "should get details" do
    get common_users_details_url
    assert_response :success
  end

end

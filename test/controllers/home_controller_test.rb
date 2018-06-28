require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get home_index_url
    assert_response :success
  end

  test "should get sysadmin" do
    get home_sysadmin_url
    assert_response :success
  end

  test "should get bizadmin" do
    get home_bizadmin_url
    assert_response :success
  end

end

require 'test_helper'

class PrivilegeControllerTest < ActionDispatch::IntegrationTest
  test "should get assign_role" do
    get privilege_assign_role_url
    assert_response :success
  end

end

require 'test_helper'

class BusinessesControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::ControllerHelpers
	def setup
		@request.env["devise.mapping"] = Devise.mappings[:user]
		@user = User.create(email:"admin@admin.com", password:"1111")
		sign_in(@user)
	end

	test "should get index" do
		get business_url
		assert_response :success
	end

	test "should get new" do
		get new_business_url
		assert_response :success
	end


end

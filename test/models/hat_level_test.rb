require 'test_helper'

class HatLevelTest < ActiveSupport::TestCase
	# test "the truth" do
	#   assert true
	# end

	test "check constraint" do

		p "  **  check constraint"
		hl = HatLevel.new
		hl.constraint = HatLevel.constraints[:free]
		p "  ** **  check free"
		assert_not hl.required?
		assert hl.multi?

		hl.constraint = HatLevel.constraints[:only_one]
		p "  ** **  check only_one"
		assert_not hl.required?
		assert_not hl.multi?

		hl.constraint = HatLevel.constraints[:required]
		p "  ** **  check required"
		assert hl.required?
		assert hl.multi?

		hl.constraint = HatLevel.constraints[:required_only_one]
		p "  ** **  check required_only_one"
		assert hl.required?
		assert_not hl.multi?

	end

end

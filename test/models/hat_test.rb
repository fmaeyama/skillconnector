require 'test_helper'

class HatTest < ActiveSupport::TestCase
	# test "the truth" do
	#   assert true
	# end

	setup do
		@hat_decorator_obj = HatDecorator.new
	end

	test "check hat container for new object" do
		hl = @hat_decorator_obj.hat_levels
		puts "check for hat_levels"
		p hl
		assert_equal hl[1].name, '役割1'
		assert_equal hl[2].name, '役割2'

		puts "check for hat_types"
		ht = @hat_decorator_obj.hat_types
		p ht
		assert_equal ht.size, 2


		assert true
	end

	test "check hat_hash method for new Business" do
		hat_array = Hat.hats_hash Business,-1, @hat_decorator_obj
		puts "　○　check for hat_hash result"
		p hat_array

		assert_equal hat_array.size, 2
		assert_equal hat_array[1][0].level.id, 1
		assert_nil hat_array[1][0].hat_type
		assert_equal hat_array[2][0].level.id, 2
		assert_nil hat_array[2][0].hat_type

	end
end

class HatLevel < ApplicationRecord
	has_many :hat_types
	enum constraint: {free:0, only_one: 1, required: 2, required_only_one:3}

	def required?
		(self .constraint_before_type_cast & HatLevel.constraints[:required]) == HatLevel.constraints[:required]
	end

	def multi?
		(self .constraint_before_type_cast & HatLevel.constraints[:only_one]) != HatLevel.constraints[:only_one]
	end

end

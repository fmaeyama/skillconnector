class HatLevel < ApplicationRecord
	has_many :hat_types
	enum constraint: {free:0, onlyone: 1, required: 2, require_onlyone:3}

	def required?
		self .constraint & HatLevel.constraints[:required] == HatLevel.constraints[:required]
	end

	def multi?
		self .constraint & HatLevel.constraints[:onlyone] != HatLevel.constraints[:onlyone]
	end

end

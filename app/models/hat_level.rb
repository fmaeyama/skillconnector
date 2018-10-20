class HatLevel < ApplicationRecord
	has_many :hat_types
	enum constraint: {free:0, onlyone: 1, required: 2, require_onlyone:3}
end

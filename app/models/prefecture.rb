class Prefecture < ApplicationRecord
	has_many :offices
	has_many :addresses
end

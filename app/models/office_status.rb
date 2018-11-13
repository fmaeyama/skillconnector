class OfficeStatus < ApplicationRecord
	has_many :offices
	scope :active, -> { order("sort_id") }
	scope :enable, -> {where("disable_from > ?", datetime).order("sort_id")}
end

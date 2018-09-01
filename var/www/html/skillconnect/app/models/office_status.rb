class OfficeStatus < ApplicationRecord
	has_many :offices
	scope :active, -> {order("sort_id") }
	scope :enamble, -> {where("disable_from < ?", time).order("sort_id")}
end

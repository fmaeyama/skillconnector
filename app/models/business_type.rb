class BusinessType < ApplicationRecord
	has_many :businesses
	scope :active,  -> {order("parent_id, id")}
	scope :enable, ->(date) {where("disable_from > ?", date).order("parent_id,id")}
end

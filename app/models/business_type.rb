class BusinessType < ApplicationRecord
	has_many :businesses
	scope :active,  -> {order("parent_id, id")}
	scope :enable, ->{where("disable_from > ?", datetime).order("parent_id,id")}
end

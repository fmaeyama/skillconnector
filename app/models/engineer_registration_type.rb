class EngineerRegistrationType < ApplicationRecord
	has_many :engineers
	scope :enable, -> {order('sort')}
end

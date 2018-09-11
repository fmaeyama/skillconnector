class EngineerRegistrationType < ApplicationRecord
	scope :enable, -> {order('sort')}
end

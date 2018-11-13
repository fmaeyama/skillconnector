class OfficeType < ApplicationRecord
	has_many :offices
	scope  :active,  -> {order('name')}
	scope  :enable, ->{where('disable_from > ?', datetime).order('name')}
end

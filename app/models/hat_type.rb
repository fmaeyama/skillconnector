class HatType < ApplicationRecord
	enum status:{inactive:0,active:1}
	scope :enable, -> {where("deleted_at is not null and status > 0")}

	belongs_to :hat_level
	has_many :hats
end

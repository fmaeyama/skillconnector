class EngineerHiring < ApplicationRecord
	belongs_to :office
	belongs_to :hiring_contact, class_name: "Contact"
	enum status:ApplicationRecord.cmn_statuses

	scope :active, -> {where('status=1')}
end

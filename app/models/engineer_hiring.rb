class EngineerHiring < ApplicationRecord
	belongs_to :office
	belongs_to :hiring_contact, class_name: "Contact", required: false
	belongs_to :engineer
	enum status:ApplicationRecord.cmn_statuses
	after_initialize :set_default_value, if: :new_record?

	scope :active, -> {where('status=1')}

	private
	def set_default_value
		self.status = 1
	end
end

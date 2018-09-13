class EngineerHiring < ApplicationRecord
	belongs_to :office
	belongs_to :hiring_contact, class_name: "Contact"
	enum status:ApplicationRecord.cmn_statuses
	after_initialize :set_default_value

	scope :active, -> {where('status=1')}

	private
	def set_default_value
		self.status = 1
	end
end

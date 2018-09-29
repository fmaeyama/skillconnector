class Office < ApplicationRecord
	belongs_to :parent, class_name: "Office", foreign_key: "parent_id", optional: true
	has_many :children, class_name: "Office", foreign_key: "parent_id"
	belongs_to :office_type
	belongs_to :primary_address, class_name: 'Address', optional: true
	belongs_to :primary_contact, class_name: 'Contact', optional: true
	belongs_to :office_status
	has_and_belongs_to_many :contacts
	has_many :businesses
	has_one :engineer_hiring

	accepts_nested_attributes_for :primary_address
	accepts_nested_attributes_for :primary_contact

	def location_short
		self.primary_address.location_short

	end

	def get_long_name
		"#{self .cd}:#{self .name}(#{self .location_short})"
	end

end

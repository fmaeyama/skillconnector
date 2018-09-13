class Engineer < ApplicationRecord
	has_one :engineer_registration_type
	has_one :engineer_status_type
	has_one :engineer_hiring
	has_one :office, through: :engineer_hiring
	has_one :person_info
	has_many :careers
	has_many :engineer_hope_businesses

	after_initialize :set_default_value

	def init_new_instance(params)

	end

	def self.engineer_params(param_hash,key)
		param_hash.require(key).permit()
	end

	private
	def set_default_value
		self.engineer_hiring=EngineerHiring.new
		self.engineer_hiring.office = Office.first
		self.engineer_registration_type = EngineerRegistrationType.first
		self.engineer_status_type = EngineerStatusType.first
	end
end

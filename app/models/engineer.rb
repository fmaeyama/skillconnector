class Engineer < ApplicationRecord
	has_one :engineer_registration_type
	has_one :engineer_status_type
	has_one :engineer_hiring
	has_one :office, through: :engineer_hiring
	has_one :engineer_person_info
	has_one :person_info, through: :engineer_person_info
	has_many :careers
	has_many :engineer_hope_businesses

	def init_new_instance(params)
		self.engineer_registration_type_id = EngineerRegistrationType.select(:id).first(1)
		self.engineer_status_type_id = EngineerStatusType.select(:id).first(1)

	end

	def self.engineer_params(param_hash,key)
		param_hash.require(key).permit()
	end
end

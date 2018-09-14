class Engineer < ApplicationRecord
	has_one :engineer_registration_type
	has_one :engineer_status_type
	has_one :engineer_hiring, autosave: true
	has_one :office, through: :engineer_hiring
	belongs_to :person_info, autosave: true
	has_many :careers
	has_many :engineer_hope_businesses


	def init_new_instance(params)
		set_default_value
	end

	def self.parameters(param_hash,key)
		param_hash.require(key).permit(
			:eng_cd,:engineer_registration_type_id,
			:registration_memo,:engineer_status_type_id,
			"PersonInfo" => [
				:last_name,:first_name,:middle_name,
				:kana_last_name,:kana_first_name, :kana_middle_name
			],
			"EngineerHiring" => [
				:office_id,:hiring_position,:hiring_division,
				:hiring_memo, :hiring_contact_id,
				:hired_from, :hired_until,:status
			]
		)
	end

	private
	def set_default_value
		self.build_engineer_hiring
		self.build_person_info
		self.office = Office.first
		self.engineer_registration_type_id = EngineerRegistrationType.select(:id).first
		self.engineer_status_type_id = EngineerStatusType.select(:id).first
	end
end

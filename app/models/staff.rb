class Staff < ApplicationRecord
  belongs_to :person_info, autosave: true
	accepts_nested_attributes_for :person_info, update_only: true
	after_initialize :set_default_value, if: :new_record?



	def self.parameters(param_hash,key)
		param_hash.require(key).permit(
			:history,
			:person_info_attributes => [
				:last_name,:first_name,:middle_name,
				:kana_last_name,:kana_first_name, :kana_middle_name
			]
		)
	end

	private
	def set_default_value
		self.build_person_info
	end
end

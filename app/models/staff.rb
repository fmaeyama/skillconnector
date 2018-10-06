class Staff < ApplicationRecord
	belongs_to :person_info, autosave: true
	accepts_nested_attributes_for :person_info, update_only: true
	after_initialize :set_default_value, if: :new_record?

	enum status: {inactive: 0, active: 1, dormant: 2}

	scope :enable, -> {where('enable_from < ? and disable_from <?', Date.today, Date.today).order('staff_cd')}

	def self.getNewCode
		id = 0
		id = Staff.last.id unless Staff.last.nil?
		"SVCD-#{"%#05d"%(id+1)}"
	end

	def self.parameters(param_hash, key)
		param_hash.require(key).permit(
			:history,:staff_cd,:enable_from,
			:disable_from,:status,
			:person_info_attributes => [
				:last_name, :first_name, :middle_name,
				:kana_last_name, :kana_first_name, :kana_middle_name
			]
		)
	end

	def get_display_name
		return "" if self.person_info.nil?
		"[#{self.person_info.staff_cd}] #{self.person_info.getFullName}"
	end

	private

		def set_default_value
			self.build_person_info
			self .status= :active
			self .staff_cd = Staff.getNewCode
			self .enable_from = Date.today
		end
end

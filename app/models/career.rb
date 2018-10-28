class Career < ApplicationRecord

	belongs_to :engineer
	belongs_to :skill, required:false
	has_many :hats, as: :hat_reference
	has_one :hat_supplement, as: :hat_supplemental
	after_initialize :set_default_value, if: :new_record?

	def history
		return '' if history.blank?

		dif = Date.today.strftime('%Y%m').to_i - self.career_from.strftime('%Y%m').to_i
		I18n.t('cmn_sentence.history', year:(dif/100).to_i.to_s, month: (dif%100).to_s)
	end

	private
	def set_default_value
		self.career_from = Date.today
		#self.skill = Skill.first
	end
end

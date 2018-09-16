class Career < ApplicationRecord
	belongs_to :engineer
	belongs_to :skill
	after_initialize set_default_value, if: :new_recored?

	def history
		return '' if history.blank?

		dif = Date.today.strftime('%Y%m').to_i - self.career_from.strftime('%Y%m').to_i
		I18n.t('cmn_sentence.history', year:(dif/100).to_i.to_s, month: (dif%100).to_s)
	end

	private
	def set_default_value
		self.skill = Skill.first
	end
end

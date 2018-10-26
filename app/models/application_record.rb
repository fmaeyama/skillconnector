module HatSkillContainer
	def associate_to_hat_skill(hs_decorator)
		raise Exception.new "hs_decorator should be a instance of SkillHatContainer" unless hs_decorator.is_a?(SkillHatContainer)

	end

end

class ApplicationRecord < ActiveRecord::Base
	self.abstract_class = true
	enum cmn_status: {disabled: 0, enabled: 1}
	enum cmn_group: {disapprove: 0, approved: 1, causion: 2}
end

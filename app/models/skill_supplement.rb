class SkillSupplement < ApplicationRecord
	belongs_to :skill_supplemental, polymorphic: true
end

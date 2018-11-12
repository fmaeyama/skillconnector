class SkillLevel < ApplicationRecord
    has_many :skill_types
    enum constraint: HatLevel.constraints

    def required?
        (self.constraint_before_type_cast & SkillLevel.constraints[:required]) == SkillLevel.constraints[:required]
    end

    def multi?
        (self.constraint_before_type_cast & SkillLevel.constraints[:only_one]) != SkillLevel.constraints[:only_one]
    end

end

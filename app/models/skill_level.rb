class SkillLevel < ApplicationRecord
    has_many :skill_types
    enum constraint: {free: 0, only_one: 1, required: 2, required_only_one: 3}

    def required?
        (self.constraint_before_type_cast & SkillLevel.constraints[:required]) == SkillLevel.constraints[:required]
    end

    def multi?
        (self.constraint_before_type_cast & SkillLevel.constraints[:only_one]) != SkillLevel.constraints[:only_one]
    end

end

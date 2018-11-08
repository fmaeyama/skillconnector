class EngineerHopeBusiness < ApplicationRecord

  include HatSkillContainer

  belongs_to :engineer
  belongs_to :business_type, required: false
  has_many :hats, as: :hat_reference
  has_many :skills, as: :skill_reference

  has_one :hat_supplement, as: :hat_supplemental
  has_one :skill_supplement, as: :skill_supplemental

  enum hope_strength: {few: 0, middle: 1, high: 2}

end

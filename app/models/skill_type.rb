class SkillType < ApplicationRecord
  enum status:{inactive:0,active:1}
  scope :enable, -> {where("deleted_at is null and status > 0")}

  belongs_to :skill_level
  has_many :skills
end

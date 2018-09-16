class Skill < ApplicationRecord
	belongs_to :parent, class_name: "Skill", foreign_key: "parent_id"
	scope :enable, -> {where.not(parent_id: 0).order(:parent_id, :sort)}
end

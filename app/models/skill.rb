class Skill < ApplicationRecord
	belongs_to :parent, class_name: "Skill", foreign_key: "parent_id"
	scope :enable, -> {order(:parent_id, :sort)}
end

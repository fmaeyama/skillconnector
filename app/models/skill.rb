class Skill < ApplicationRecord
	belongs_to :parent, class_name: "Skill", foreign_key: "parent_id"
	has_and_belongs_to_many :offers
	has_many :careers
	has_many :engineer_hope_businesses
	scope :enable, -> {order(:parent_id, :sort)}
end

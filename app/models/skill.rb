class Skill < ApplicationRecord
  belongs_to :parent, class_name: "Skill", foreign_key: "parent_id"
end

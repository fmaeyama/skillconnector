class ModifySkills < ActiveRecord::Migration[5.2]
  def up
    add_column :skills, :skill_type_id, :bigint, index: true, comment: Skill.human_attribute_name('skill_type')
    add_column :skills, :skill_reference_type, :string, index: true
    add_column :skills, :skill_reference_id, :bigint, comment: Skill.human_attribute_name('skill_reference')
    add_column :skills, :memo, :string
    remove_columns :skills, :name, :description, :sort, :parent_id
  end

  def down
    remove_columns :skills, :skill_type_id, :skill_reference_type, :skill_reference_id, :memo
    add_column :skills, :name, :string
    add_column :skills, :description, :string
    add_column :skills, :sort, :integer
    add_column :skills, :parent_id, :bigint
  end
end

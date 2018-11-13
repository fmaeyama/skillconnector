class AddColumnSkills < ActiveRecord::Migration[5.2]
  def change
    add_column :skills, :trained_type_id, :bigint, index: true, comment: Skill.human_attribute_name('trained_type')
  end
end

class ModifySkills < ActiveRecord::Migration[5.2]
	def change
		add_column :skills, :skill_type, :string, comment: Skill.human_attribute_name('skill_type')
		add_column :skills, :skill_reference_type, :string, index:true
		add_column :skills, :skill_reference_id, :bigint, comment: Skill.human_attribute_name('skill_reference')
		remove_columns :skills, :name, :description, :sort, :parent_id
	end
end

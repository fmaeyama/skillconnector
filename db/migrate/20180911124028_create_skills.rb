class CreateSkills < ActiveRecord::Migration[5.2]
	def change
		create_table :skills, comment: Skill.model_name.human do |t|
			t.string :name, comment: Skill.human_attribute_name("name")
			t.string :description,
				comment:Skill.human_attribute_name("description")
			t.references :parent, foreign_key: {to_table: :skills},
				comment:Skill.human_attribute_name("parent")
			t.integer :sort

			t.timestamps
		end
	end
end

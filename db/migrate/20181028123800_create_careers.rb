class CreateCareers < ActiveRecord::Migration[5.2]
	def change
		create_table :careers,comment:Career.model_name.human do |t|
			t.references :engineer, foreign_key: true
			t.references :skill,foreing_key: true
			t.string :description, comment:Career.human_attribute_name("description")
			t.date :career_from, comment:Career.human_attribute_name("career_from")
			t.string :career_at, comment:Career.human_attribute_name("career_at")

			t.timestamps
		end
	end
end

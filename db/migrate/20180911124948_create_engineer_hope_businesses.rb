class CreateEngineerHopeBusinesses < ActiveRecord::Migration[5.2]
	def change
		create_table :engineer_hope_businesses, comment: EngineerHopeBusiness.model_name.human do |t|
			t.references :engineer, foreign_key: true
			t.references :business_type, foreign_key: true,
				comment:EngineerHopeBusiness.human_attribute_name('business_type')
			t.references :skill, foreign_key: true,
				comment:EngineerHopeBusiness.human_attribute_name('skill')
			t.string :description,
				comment:EngineerHopeBusiness.human_attribute_name("description")
			t.date :hope_since,
				comment:EngineerHopeBusiness.human_attribute_name("hope_since")
			t.integer :hope_strength,
				comment:EngineerHopeBusiness.human_attribute_name("hope_strength")

			t.timestamps
		end
	end
end

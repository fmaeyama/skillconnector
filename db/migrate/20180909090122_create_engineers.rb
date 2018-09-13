class CreateEngineers < ActiveRecord::Migration[5.2]
	def change
		create_table :engineers, comment: Engineer.model_name.human do |t|
			t.string :eng_cd, comment: Engineer.human_attribute_name("eng_cd")
			t.references :engineer_registration_type, foreign_key: true,
				comment: EngineerRegistrationType.model_name.human
			t.string :registration_memo, comment: Engineer.human_attribute_name("registration_memo")
			t.references :engineer_status_type, foreign_key: true, comment: EngineerStatusType.model_name.human
			t.references :person_info, foreign_key: true,
				comment: Engineer.human_attribute_name("person_info")

			t.timestamps
		end
	end
end

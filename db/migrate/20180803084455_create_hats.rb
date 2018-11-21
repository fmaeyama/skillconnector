class CreateHats < ActiveRecord::Migration[5.2]
	def change
		create_table :hats, comment: Hat.model_name.human do |t|
			t.references :hat_type, comment: HatType.model_name.human
			t.references :hat_reference, polymorphic:true, index:true, comment:Hat.human_attribute_name("hat_reference")
			t.string :memo
			t.timestamps
		end
	end
end

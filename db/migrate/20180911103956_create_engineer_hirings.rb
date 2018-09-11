class CreateEngineerHirings < ActiveRecord::Migration[5.2]
  def change
    create_table :engineer_hirings,comment: EngineerHiring.model_name.human do |t|
      t.references :engineer, foreign_key:true
      t.references :office, foreign_key: true,
          comment:EngineerHiring.human_attribute_name("office")
      t.string :hiring_position,
          comment:EngineerHiring.human_attribute_name("hiring_position")
      t.string :hiring_division,
          comment:EngineerHiring.human_attribute_name("hiring_division")
      t.string :hiring_memo,
          comment:EngineerHiring.human_attribute_name("hiring_memo")
      t.references :hiring_contact, foreign_key: {to_table: :contacts},
          comment:EngineerHiring.human_attribute_name("hiring_contact")
      t.date :hired_from,comment:EngineerHiring.human_attribute_name("hired_from")
      t.date :hired_until, comment:EngineerHiring.human_attribute_name("hired_until")
      t.integer :status, comment:EngineerHiring.human_attribute_name("status")

      t.timestamps
    end
  end
end

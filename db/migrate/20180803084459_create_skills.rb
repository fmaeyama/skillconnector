class CreateSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :skills, comment: Skill.model_name.human do |t|
      t.references :skill_type, comment: Skill.human_attribute_name('skill_type')
      t.references :skill_reference, polymorphic:true, index:true, comment: Skill.human_attribute_name('skill_reference')
      t.references :parent, foreign_key: {to_table: :skills},
        comment: Skill.human_attribute_name("parent")
      t.string :memo
      t.integer :sort

      t.timestamps
    end
  end
end

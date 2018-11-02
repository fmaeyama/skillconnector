class CreateSkillTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :skill_types, comment: SkillType.model_name.human do |t|
      t.string :name
      t.string :description
      t.references :skill_level, foreign_key: true, comment: SkillLevel.model_name.human
      t.references :parent_skill, foreign_key: {to_table: :skill_types}, comment: SkillType.human_attribute_name('parent_skill')
      t.integer :status
      t.date :deleted_at

      t.timestamps
    end
  end
end

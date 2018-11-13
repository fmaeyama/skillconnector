class CreateSkillLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :skill_levels, comment:SkillLevel.model_name.human do |t|
      t.string :name
      t.string :description
      t.integer :constraint
      t.timestamps
    end
  end
end

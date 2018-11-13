class CreateSkillSupplements < ActiveRecord::Migration[5.2]
  def change
    create_table :skill_supplements do |t|
      t.references :skill_supplemental, polymorphic: true, index:{name:"index_skill_supplemental"}
      t.string :memo

      t.timestamps
    end
  end
end

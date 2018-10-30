class AddDeleteAtToSkillTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :skill_types, :deleted_at, :date
  end
end

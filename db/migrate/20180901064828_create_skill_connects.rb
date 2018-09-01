class CreateSkillConnects < ActiveRecord::Migration[5.2]
  def change
    create_table :skill_connects do |t|

      t.timestamps
    end
  end
end

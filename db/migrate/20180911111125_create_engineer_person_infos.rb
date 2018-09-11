class CreateEngineerPersonInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :engineer_person_infos,comment:EngineerPersonInfo.model_name.human do |t|
      t.references :engineer, foreign_key: true
      t.references :person_info, foreign_key: true

      t.timestamps
    end
  end
end

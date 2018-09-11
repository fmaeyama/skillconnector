class CreateEngineerRegistrationTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :engineer_registration_types, comment: EngineerRegistrationType.model_name.human do |t|
      t.string :name, comment:'流入種別'
      t.string :description, comment: '流入種別詳細'
      t.integer :sort, comment:'並び順'

      t.timestamps
    end
  end
end

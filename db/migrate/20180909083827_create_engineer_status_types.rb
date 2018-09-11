class CreateEngineerStatusTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :engineer_status_types do |t|
      t.string :name
      t.string :description
      t.integer :sort
      t.integer :group, comment:"表示フラグ, cmn_enum.group"
      t.date :disable_from, default:"9999-12-31"

      t.timestamps
    end
  end
end

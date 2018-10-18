class CreateHatLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :hat_levels, comment:HatLevel.model_name.human do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end

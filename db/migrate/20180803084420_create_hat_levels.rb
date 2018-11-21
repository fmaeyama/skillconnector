class CreateHatLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :hat_levels, comment: HatLevel.model_name.human do |t|
      t.string :name
      t.string :description
      t.integer :constraint, comment: "選択制約 HatLevel.constraints"
      t.integer :evaluation_type, comment: "評価軸 cmn_evaluation_type"
      t.timestamps
    end
  end
end

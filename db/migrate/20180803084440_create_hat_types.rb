class CreateHatTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :hat_types do |t|
      t.string :name
      t.string :description
      t.references :hat_level
      t.references :parent_hat
      t.integer :status
      t.date :deleted_at

      t.timestamps
    end
  end
end

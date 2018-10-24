class CreateHatSupplements < ActiveRecord::Migration[5.2]
  def change
    create_table :hat_supplements do |t|
      t.reference{polymorphic} :hat_supplemental
      t.string :memo

      t.timestamps
    end
  end
end

class CreateHatSupplements < ActiveRecord::Migration[5.2]
  def change
    create_table :hat_supplements do |t|
      t.references :hat_supplemental, polymorphic: true, index:{name: "index_hat_supplemental"}
      t.string :memo

      t.timestamps
    end
  end
end

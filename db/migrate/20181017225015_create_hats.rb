class CreateHats < ActiveRecord::Migration[5.2]
  def change
    create_table :hats, comment:Hat.model_name.human do |t|
      t.string :name
      t.string :description
      t.referenses :hat_level, comment:HatLevel.model_name.human
      t.referenses :parent_hat, foreign_key: {to_table: :hats}, null:true, comment:Hat.human_attribute_name("parent_hat")
      t.integer :status
      t.date :deleted_at

      t.timestamps
    end
  end
end

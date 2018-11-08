class CreateTrainedTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :trained_types, comment: TrainedType.model_name.human do |t|
      t.string :name
      t.string :description
      t.integer :rate
      t.integer :status

      t.timestamps
    end
  end
end

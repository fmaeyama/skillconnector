class CreateTrainedHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :trained_histories do |t|
      t.references :trained_type, foreign_key: true
      t.references :evaluation, polymorphic:true, index: true
      t.date :evaluated_at

      t.timestamps
    end
  end
end

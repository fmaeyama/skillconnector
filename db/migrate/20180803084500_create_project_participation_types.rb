class CreateProjectParticipationTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :project_participation_types, comment: ProjectParticipationType.model_name.human do |t|
      t.string :name
      t.string :description
      t.integer :status
      t.date :deleted_at

      t.timestamps
    end
  end
end

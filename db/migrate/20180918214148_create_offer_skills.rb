class CreateOfferSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :offer_skills, comment:OfferSkill.model_name.human do |t|
      t.references :offer, foreign_key: true
      t.references :skill, foreign_key: true

      t.timestamps
    end
  end
end

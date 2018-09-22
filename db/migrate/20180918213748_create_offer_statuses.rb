class CreateOfferStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :offer_statuses, comment:OfferStatus.model_name.human do |t|
      t.string :name
      t.string :description
      t.integer :sort
      t.references :parent, foreign_key:{to_table: :offer_statuses}

      t.timestamps
    end
  end
end

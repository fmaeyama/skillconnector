class CreateOfferStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :offer_statuses, comment:OfferStatus.model_name.human do |t|
      t.string :name
      t.string :description
      t.integer :sort
      t.integer :group, comment:"表示フラグ, cmn_enum.group"

      t.timestamps
    end
  end
end

class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers, comment:Offer.model_name.human do |t|
      t.references :business, foreign_key: true, comment:Business.model_name.human
      t.string :title, comment:Offer.human_attribute_name("title")
      t.string :description, commnet:Offer.human_attribute_name("description")
      t.references :offer_status, foreign_key: true, comment:OfferStatus.model_name.human
      t.date :start_from, default:->{'CURRENT_DATE'}, commnet:Offer.human_attribute_name("start_from")
      t.date :want_until, default:'9999-12-31', comment:Offer.human_attribute_name("want_until")
      t.string :work_at, comment:Offer.human_attribute_name('work_at')

      t.timestamps
    end
  end
end

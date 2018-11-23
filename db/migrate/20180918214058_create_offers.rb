class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers, comment:Offer.model_name.human do |t|
      t.references :business, foreign_key: true, comment:Business.model_name.human
      t.string :title, comment:Offer.human_attribute_name("title")
      t.string :description, commnet:Offer.human_attribute_name("description")
      t.string :welcome, comment:Offer.human_attribute_name("welcome")
      t.references :offer_status, foreign_key: true, comment:OfferStatus.model_name.human
      t.date :start_from, default:->{'CURRENT_DATE'}, commnet:Offer.human_attribute_name("start_from")
      t.date :want_until, default:'9999-12-31', comment:Offer.human_attribute_name("want_until")
      t.string :work_at, comment:Offer.human_attribute_name('work_at')

      # t.references :business, foreign_key: true, comment:Business.model_name.human
      # t.string :title, comment:Offer.human_attribute_name("title")
      # t.string :description, commnet:Offer.human_attribute_name("description")
      # t.references :offer_status, foreign_key: true, comment:OfferStatus.model_name.human
      # t.references :project_participation_type, comment: ProjectParticipationType.model_name.human
      # t.date :open_date, default: -> {'CURRENT_DATE'}, comment: "受付開始日"
      # t.date :enable_date, default: -> {'CURRENT_DATE'}, comment: "受入可能日"
      # t.date :want_until, default:'9999-12-31', comment:Offer.human_attribute_name("want_until")
      # t.date :start_from, default:->{'CURRENT_DATE'}, commnet:Offer.human_attribute_name("start_from")
      # t.date :end_date, default: '9999-12-31', comment: "受付締切日"
      # t.string :work_at, comment:Offer.human_attribute_name('work_at')



      t.timestamps
    end
  end
end

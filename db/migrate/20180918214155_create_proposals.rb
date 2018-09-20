class CreateProposals < ActiveRecord::Migration[5.2]
  def change
    create_table :proposals, comment:Proposal.model_name.human do |t|
      t.references :offer, foreign_key: true, comment:Offer.model_name.human
      t.references :engineer, foreign_key: true, comment:Engineer.model_name.human
      t.references :offered_staff, foreign_key: {to_table: :staffs}, comment:Proposal.human_attribute_name("offered_staff")
      t.references :office_contact, foreign_key: {to_table: :contacts}, comment:Proposal.human_attribute_name("office_contacts")
      t.string :history

      t.timestamps
    end
  end
end

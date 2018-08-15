class CreateOfficeContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :office_contacts, comment:'事業所連絡先' do |t|
      t.belongs_to :office,  index: true
      t.belongs_to :contact, index: true

      t.timestamps
    end
  end
end

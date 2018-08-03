class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts, comment: "汎用連絡先項目" do |t|
      t.string :contact_name, comment:"連絡先（人名等）"
      t.string :contact_kana, comment:"連絡先ふりがな"
      t.string :title, comment:"連絡先種別"
      t.integer :contact_type, default:0, comment:"連絡先区分{email:0,tel:1,fax:2}"
      t.string :contact_value, comment:"アドレス、電話番号など"

      t.timestamps
    end
  end
end

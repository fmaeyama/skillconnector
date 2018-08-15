class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses, comment: "汎用住所項目" do |t|
      t.string :postal_code, comment: "郵便番号（ハイフン無し）"
      t.references :prefecture
      t.string :address, comment: "市区町村以下番地まで"
      t.string :building, comment: "ビル名以下"
      t.string :about_this, comment: "アドレス説明"

      t.timestamps
    end
  end
end

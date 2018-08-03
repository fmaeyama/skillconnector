class CreatePrefectures < ActiveRecord::Migration[5.2]
  def change
    create_table :prefectures, comment: "都道府県" do |t|
      t.string :name, comment: "都道府県名"
      t.string :name_e
      t.string :name_h
      t.string :name_k
      t.string :area
      t.timestamps
    end
  end
end

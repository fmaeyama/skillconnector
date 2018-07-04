class CreatePersonInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :person_infos, comment: '共通人材情報' do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :kana_first_name
      t.string :kana_middle_name
      t.string :kana_last_name
      t.text :memo, comment: '検索用情報項目'
      t.integer :user_status,default: 1, comment: '{0:無効, 1:有効}'

      t.timestamps
    end
  end
end

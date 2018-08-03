class CreateOfficeStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :office_statuses, comment:"事業所契約状態" do |t|
      t.string :name, comment:"表示名称"
      t.string :description, comment:"詳細"
      t.integer :sort_id, comment:"並び順"
      t.integer :group_id, comment: "表示制御グループ {prospective:0, active:1, resumed:2, expired:3}"
      t.boolean :status, comment: "表示フラグ cmn_enum.status"
      t.date :disable_from, default:"9999-12-31", comment:"新規利用停止日"

      t.timestamps
    end
  end
end

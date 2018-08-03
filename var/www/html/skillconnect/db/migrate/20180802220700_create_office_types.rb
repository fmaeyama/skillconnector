class CreateOfficeTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :office_types, comment: "事業所種別" do |t|
      t.string :name, comment: "事業所種別名称"
      t.boolean :status, comment: "cmn_enum.status"
      t.date :disable_from, default:"9999-12-31",null:false, comment: "新規利用停止日"

      t.timestamps
    end
  end
end

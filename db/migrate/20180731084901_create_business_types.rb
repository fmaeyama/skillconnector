class CreateBusinessTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :business_types,comment: "業務種別" do |t|
      t.string :name, comment: "業務種別名称"
      t.references :parent_id, null: true, foreign_key: {to_table: :business_types}, comment: "親業務種別"
      t.boolean :status, comment: "cmn_enum.status"
      t.date :disable_from, default:"9999-12-31",null:false, comment: "新規利用停止日"

      t.timestamps
    end
  end
end

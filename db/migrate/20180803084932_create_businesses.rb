class CreateBusinesses < ActiveRecord::Migration[5.2]
  def change
    create_table :businesses, comment: "業務" do |t|
      t.string :name, null:false, comment: "業務タイトル"
      t.string :description, null:false, comment: "詳細内容"
      t.string :welcome, null:false, comment: "歓迎技術者"
      t.references :office, foreign_key: true, comment: "募集事業所"
      t.references :business_type, comment: "業務種別"
      t.references :business_status, comment: "募集状態"
      t.references :parent_business, foreing_key: {to_table: :businesses}, null:true, comment: "親業務"
      t.integer :max_quantity, comment: "受入可能人数"
      t.integer :proper_quantity, comment: "希望募集人数"
      t.money :budget, comment: "予算"
      t.date :open_date, default: -> {'CURRENT_DATE'}, comment: "受付開始日"
      t.date :enable_date, default: -> {'CURRENT_DATE'}, comment: "受入可能日"
      t.date :end_date, default: '9999-12-31', comment: "受付締切日"
      t.date :expire_schedule, default: '9999-12-31', comment: "データ削除予定日"

      t.timestamps
    end
  end
end

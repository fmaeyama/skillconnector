class CreateCmnPropertyTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :cmn_property_types, comment: '属性種別' do |t|
      t.string :title, comment: '属性のタイトル', null: false
      t.text :description, comment: '属性に記載すべきものの説明'
      t.integer :property_datatype, default: 0, comment: '{string: 0, date:1 , datetime: 2, integer: 3, file:4, class_id:5}'
      t.string :data_class, comment: 'property_datatype=5の時のクラス名. find(CmnProperty.contents)が属性'
      t.date :enable_date, comment: '有効日(入力可能開始日)' , default: { expr: "('now'::text)::date" }
      t.date :deprecated_date, comment: '入力非推奨開始日'

      t.timestamps
    end
  end
end

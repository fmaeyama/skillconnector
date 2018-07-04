class CreateCmnProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :cmn_properties,comment: '属性情報' do |t|
      t.references :cmn_property_type, foreign_key: true
      t.text :contents, null: false, comment: '属性値'
      t.boolean :is_active
      t.text :staff_memo

      t.timestamps
    end
  end
end

class CreateControllePrivileges < ActiveRecord::Migration[5.2]
  def change
    create_table :controlle_privileges, comment: 'コントロール毎権限設定' do |t|
      t.references :user_privilege_group, foreign_key: true
      t.string :controll_name, comment: '操作対象コントロール'
      t.integer :privilage_type, comment: '{0: 全てのアクションが利用可能, 1: 一部のアクションが利用可能}'

      t.timestamps
    end
  end
end

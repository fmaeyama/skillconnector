class CreateUserPrivilegeGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :user_privilege_groups, comment: 'ログインユーザー毎権限設定' do |t|
      t.references :user, foreign_key: true
      t.references :privilege_group, foreign_key: true

      t.timestamps
    end
  end
end

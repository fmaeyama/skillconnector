class CreatePrivilegeGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :privilege_groups, comment: '権限グループ' do |t|
      t.string :title
      t.string :descriptions

      t.timestamps
    end
    
  end
end

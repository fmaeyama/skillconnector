class CreateControlPrivileges < ActiveRecord::Migration[5.2]
  def change
    create_table :control_privileges do |t|
      t.references :privilege_group, foreign_key: true
      t.string :controller_name
      t.integer :privilege_type

      t.timestamps
    end
  end
end

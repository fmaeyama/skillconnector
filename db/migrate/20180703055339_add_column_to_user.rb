class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :person_info_id, :integer
  end
end

class CreateStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :staffs, comment:Staff.model_name.human do |t|
      t.references :person_info, foreign_key: true
      t.string :history

      t.timestamps
    end
  end
end

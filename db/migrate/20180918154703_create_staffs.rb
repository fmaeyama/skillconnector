class CreateStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :staffs, comment:Staff.model_name.human do |t|
      t.string :staff_cd, comment: Staff.human_attribute_name('staff_cd')
      t.references :person_info, foreign_key: true
      t.string :history
      t.date :enable_from,  comment: Staff.human_attribute_name('enable_from')
      t.date :disable_from,  comment: Staff.human_attribute_name('disable_from'), default:"9999-12-31"
      t.integer :status, comment: "staff_enum.staff_status"

      t.timestamps
    end
  end
end

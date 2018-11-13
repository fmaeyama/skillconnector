class AddStaffCdToStaffs < ActiveRecord::Migration[5.2]
	def change
		add_column :staffs, :staff_cd, :string, comment: Staff.human_attribute_name('staff_cd')
		add_column :staffs, :enable_from, :date, comment: Staff.human_attribute_name('enable_from')
		add_column :staffs, :disable_from, :date, comment: Staff.human_attribute_name('disable_from'), default:"9999-12-31"
		add_column :staffs, :status, :integer, comment: "staff_enum.staff_status"
	end
end


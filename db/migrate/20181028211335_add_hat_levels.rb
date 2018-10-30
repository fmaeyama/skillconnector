class AddHatLevels < ActiveRecord::Migration[5.2]
	def change
		add_column :skill_levels, :constraint, :integer
	end
end

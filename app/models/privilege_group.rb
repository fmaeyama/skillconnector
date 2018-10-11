class PrivilegeGroup < ApplicationRecord
	has_many :control_privileges
	belongs_to :user
end

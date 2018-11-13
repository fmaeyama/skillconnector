class PrivilegeGroup < ApplicationRecord
	has_many :control_privileges
end

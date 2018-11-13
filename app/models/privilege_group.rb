class PrivilegeGroup < ApplicationRecord
  has_many :control_privileges
  has_many :users, through: :user_privilege_groups
end

class UserPrivilegeGroup < ApplicationRecord
  belongs_to :user
  belongs_to :privilege_group
end

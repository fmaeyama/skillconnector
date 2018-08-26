class ControlPrivilege < ApplicationRecord
  belongs_to :privilege_group
  enum privilege_type: {allow_all:0, allow_partial:1}
end

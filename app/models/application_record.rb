class ApplicationRecord < ActiveRecord::Base
	self.abstract_class = true
	enum cmn_status: {disabled: 0, enabled: 1}
	enum cmn_group: {disapprove: 0, approved: 1, causion: 2}
end

class PersonInfo < ApplicationRecord
	has_one :user
	has_one :engineer

	enum user_status: ApplicationRecord.cmn_statuses

end

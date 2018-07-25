class PersonInfo < ApplicationRecord
	has_one :user

	enum user_status: ApplicationRecord.cmn_statuses

end

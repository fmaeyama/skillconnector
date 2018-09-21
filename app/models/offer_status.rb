class OfferStatus < ApplicationRecord
	enum offer_group: ApplicationRecord.cmn_groups

	scope :enable,->{order("group, sort")}

end

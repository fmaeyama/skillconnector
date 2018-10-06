class Proposal < ApplicationRecord
	belongs_to :offer
	belongs_to :engineer
	belongs_to :offered_staff, class_name: 'Staff'
	belongs_to :office_contact, class_name: 'Contact'

	def other_engineers
		Engineer.joins(:proposals).where("proposals.offer_id=?", self.offer_id).where.not({proposals: {id:self .id}})
	end

	def other_offers
		Offer.joins(:proposals).where({proposals:{engineer_id: self .engineer_id}}).where.not({proposals:{id:self .id}})
	end
end

class Proposal < ApplicationRecord
	belongs_to :offer
	belongs_to :engineer
	belongs_to :offered_staff, class_name: 'Staff'
	belongs_to :office_contact, class_name: 'Contact', required: false
	scope :related_office, -> {joins(:offer).joins(:business).joins(:office)}

	def other_engineers
		Engineer.select("engineers.*", "proposals.id as proposalid").joins(:proposals).where("proposals.offer_id=?", self.offer_id).where.not({proposals: {id:self .id}})
	end

	def other_offers
		Offer.select("offers.*","proposals.id as proposalid").joins(:proposals).where({proposals:{engineer_id: self .engineer_id}}).where.not({proposals:{id:self .id}})
	end


	def get_related_office_id
		office=Office.joins(businesses:[offers: [:proposals]]).where("proposals.id=?",self.id)
		return -1 if office.size == 0
		office.first!.id
	end

	def description
		res = ""
		res += self .engineer.person_info.getFullName unless self.engineer.person_info.blank?
		res += " "
		res += self.offer.title unless self .offer.blank?
		return res
	end

	def self.parameters(params, key)
		params.require(key).permit(
			:offer_id, :engineer_id, :offered_staff_id, :office_contact_id,
			:history
		)
	end

end

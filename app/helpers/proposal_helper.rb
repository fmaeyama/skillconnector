module ProposalHelper

	def helper_get_office_contacts(proposal)
		result = [{id:-1,name:I18n.t("cmn_dict.not_defined")}]
		return result if proposal.offer.nil?
		return result if proposal.offer.business.nil?
		return result if proposal.offer.business.office.nil?
		Contact.office_contact(proposal.offer.business.office.id)
	end
end

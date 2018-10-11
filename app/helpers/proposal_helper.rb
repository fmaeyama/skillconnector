module ProposalHelper

	def helper_get_office_contacts(proposal)
		result = [{id:-1,name:I18n.t("cmn_dict.not_defined")}]
		return result if proposal.offer.nil?
		return result if proposal.offer.business.nil?
		return result if proposal.offer.business.office.nil?
		Contact.office_contact(proposal.offer.business.office.id)
	end

	def helper_get_proposal_link(proposal)
		content_tag :h3 do
			concat "id:"
			concat content_tag(:span, proposal.id,id:"proposal-id-#{proposal.id}", class:"sl-content")
			concat link_to(content_tag(:span, proposal.description, id:"proposal-title-#{proposal.id}", class:"sl-title" ),url_for(action:"edit", id:proposal.id))
		end
	end
end

module ProposalHelper

  def helper_get_office_contacts(proposal)
    contacts = []
    id = proposal.get_related_office_id
    if id > -1
      contacts = Contact.office_contact(id)
    end
    return [{id: -1, contact_name: I18n.t("cmn_dict.not_defined")}] if (id == -1 || contacts.size ==0)
    contacts
  end

  def helper_get_proposal_link(proposal)
    content_tag :h3 do
      concat "id:"
      concat content_tag(:span, proposal.id, id: "proposal-id-#{proposal.id}", class: "sl-content")
      concat link_to(content_tag(:span, proposal.description, id: "proposal-title-#{proposal.id}", class: "sl-title"), url_for(action: "edit", id: proposal.id))
    end
  end

  def helper_description_of_other_proposal(other_offer)
    title = other_offer.title
    title = "#{title}(#{other_offer.business_name})" unless other_offer.business_name == other_offer.title
    "#{Business.model_name.human}:BSNS#{other_offer.id}#{title}"
  end

end

module OfferHelper
	def get_offer_link(offer)
		content_tag :h3 do
			concat "id:"
			concat content_tag(:span, offer.id,id:"offer-id-#{offer.id}", class:"sl-content")
			concat link_to(content_tag(:span, offer.title, id:"business-title-#{offer.id}", class:"sl-title" ),url_for(action:"edit", id:offer.id))
			concat "("
			concat content_tag(:span, offer.description,id:"offer-description-#{offer.id}", class:"sl-content" )
			concat ")"
		end
	end
end

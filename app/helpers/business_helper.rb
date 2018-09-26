module BusinessHelper
	def get_parent_part(business)
		button_tag() if businesses.parent_id == 0
	end

	def helper_call_offer_title_if_exists
		render( partial: 'offer/offer', collection:@business.offers) if @business.offers.blank?

		content_tag(:div, class:"row") do
			content_tag(:div,
				t('cmn_sentence.noRelatedTitle', model:Offer.model_name.human) ,
				class:"col-md-8 col-md-offset-2")
		end
	end

	def get_business_link(business)
		content_tag :h3 do
			concat "id:"
			concat content_tag(:span, business.id,id:"business-id-#{business.id}", class:"sl-content")
			concat link_to(content_tag(:span, business.name, id:"business-name-#{business.id}", class:"sl-title" ),url_for(action:"edit", id:business.id))
			concat "("
			concat content_tag(:span, business.description,id:"business-name-#{business.id}", class:"sl-content" )
			concat ")"
		end
	end


end

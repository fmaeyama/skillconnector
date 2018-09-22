module BusinessesHelper
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
end

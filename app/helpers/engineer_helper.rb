module EngineerHelper

	def helper_get_link_from_var(engineer, var)
		case var.model_name
			when Offer.model_name.human
				"OFFER"
				link_to(engineer.person_info.getFullName, url_for(controller: "proposal",action: "new", offer:var.mode, engineer:engineer.id))
			else
				engineer.person_info.getFullName
		end
	end
end

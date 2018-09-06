module BusinessesHelper
	def get_parent_part(business)
		button_tag() if businesses.parent_id == 0
	end
end

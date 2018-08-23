class Contact < ApplicationRecord
	has_many :offices
	enum contact_types: {email:0,tel:1,fax:2}

	def self.permitParams(params, key)
		params.require(key).permit(
			:contact_name, :contact_kana, :title,
			:contact_type, :contact_value
		)
	end
end

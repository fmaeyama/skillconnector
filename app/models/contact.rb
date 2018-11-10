class Contact < ApplicationRecord
	has_and_belongs_to_many :offices
	has_many :office_primaries, class_name:'Office', foreign_key: 'primary_contact_id'
	enum contact_type: {email:0,tel:1,fax:2}

	scope :office_contact, -> (office_id) do
		Contact.left_joins(:offices).left_joins(:office_primaries).where("offices.id = ? or office_primaries_contacts.id=?", office_id, office_id)
	end

	def display_name
		"#{self .contact_name} (#{self .title})"
	end

	def self.permitParams(params, key)
		params.require(key).permit(
			:contact_name, :contact_kana, :title,
			:contact_type, :contact_value
		)
	end
end

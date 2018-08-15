class Contact < ApplicationRecord
	has_many :offices
	enum contact_types: {email:0,tel:1,fax:2}
end

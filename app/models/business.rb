class Business < ApplicationRecord
  belongs_to :parent
  belongs_to :business_type
  belongs_to :address
  belongs_to :primary_contact
end

class Office < ApplicationRecord
  belongs_to :parent
  belongs_to :office_type
  belongs_to :primary_address
  belongs_to :primary_contact
  belongs_to :office_status
end

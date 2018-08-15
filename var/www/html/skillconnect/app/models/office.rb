class Office < ApplicationRecord
  belongs_to :parent, class_name: "Office"
  has_many :child, class_name: "Office", foreign_key: "parent_id"
  belongs_to :office_type
  belongs_to :primary_address
  belongs_to :primary_contact
  belongs_to :office_status
  has_many :contacts
  has_many :businesses
end

class Office < ApplicationRecord
  belongs_to :parent, class_name: "Office", optional: true
  has_many :child, class_name: "Office", foreign_key: "parent_id"
  belongs_to :office_type, optional: true
  belongs_to :primary_address, optional: true
  belongs_to :primary_contact, optional: true
  belongs_to :office_status
  has_many :contacts, through: :office_contacts
  has_many :businesses
end

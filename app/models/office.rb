class Office < ApplicationRecord
  belongs_to :parent, class_name: "Office", foreign_key: "parent_id", optional: true
  has_many :children, class_name: "Office", foreign_key: "parent_id"
  belongs_to :office_type
  belongs_to :primary_address, class_name:'Address', optional: true
  belongs_to :primary_contact, class_name:'Contact', optional: true
  belongs_to :office_status
  has_many :contacts, through: :office_contacts
  has_many :businesses

  accepts_nested_attributes_for :primary_address
  accepts_nested_attributes_for :primary_contact


end

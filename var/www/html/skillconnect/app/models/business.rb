class Business < ApplicationRecord
  belongs_to :parent, class_name: "Business"
  has_many :child, class_name: "Business", foreign_key: "parent_business_id"
  belongs_to :business_type
  belongs_to :business_status
  belongs_to :office
end

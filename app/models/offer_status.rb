class OfferStatus < ApplicationRecord
  has_one :parent, class_name: "OfferStatus", foreign_key: "parent_id"
  has_many :children, class_name: "OfferStatus", foreign_key: "parent_id"

  scope :enable, -> {order("parent_id, sort")}

end

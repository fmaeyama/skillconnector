class OfferStatus < ApplicationRecord
  has_one :parent, class_name: "OfferStatus", foreign_key: "parent_id"
  has_many :children, class_name: "OfferStatus", foreign_key: "parent_id"
  # 以下、OfficeStatus.yml で設定。外部から参照用
  STATUS_CLOSED=1
  STATUS_OPEN=2

  scope :enable, -> {order("parent_id, sort")}

end

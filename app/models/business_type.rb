# Business = 案件の業務属性はHat, Skillに移動したので、こちらは廃止とします
class BusinessType < ApplicationRecord
  has_many :businesses
  scope :active, -> {order("parent_id, id")}
  scope :enable, ->(date) {where("disable_from > ?", date).order("parent_id,id")}
end

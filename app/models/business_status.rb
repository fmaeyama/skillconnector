class BusinessStatus < ApplicationRecord
  has_many :businesses
  scope :active, -> {order("sort_id")}
  scope :enable, -> {where("disable_from > ?", datetime).order("sort_id")}

  class Grid < InnerGrid

  end

end

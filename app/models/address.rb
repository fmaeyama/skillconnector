class Address < ApplicationRecord
  belongs_to :prefecture
  has_many :offices
end

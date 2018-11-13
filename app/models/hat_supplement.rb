class HatSupplement < ApplicationRecord
  belongs_to :hat_supplemental, polymorphic: true
end

class Staff < ApplicationRecord
  belongs_to :person_info
  belongs_to :history
end

class TrainedHistory < ApplicationRecord
  belongs_to :traind_type
  belongs_to :evaluation, polymorphic: true
end

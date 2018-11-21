class TrainedHistory < ApplicationRecord
  belongs_to :trained_type
  belongs_to :evaluation, polymorphic: true
end

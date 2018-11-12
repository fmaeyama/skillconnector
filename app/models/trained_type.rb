class TrainedType < ApplicationRecord
  has_many :skills
  enum status: ApplicationRecord.cmn_statuses

  scope :active, -> {where(status: :enabled).order("rate")}

end

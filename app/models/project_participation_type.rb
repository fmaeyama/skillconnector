class ProjectParticipationType < ApplicationRecord
  enum status: ApplicationRecord.cmn_statuses
  scope :enable, ->{where(status: :enabled )}
end

class Proposal < ApplicationRecord
  belongs_to :offer
  belongs_to :engineer
  belongs_to :offered_staff, class_name: 'Staff'
  belongs_to :office_contact, class_name: 'Contact'
end

class OfficeContact < ApplicationRecord
  belongs_to :office_id
  belongs_to :contact_id
end

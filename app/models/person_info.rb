class PersonInfo < ApplicationRecord
  has_one :user
  has_one :engineer

  enum user_status: ApplicationRecord.cmn_statuses

  def getFullName
    self.last_name +
      (self.middle_name.blank? ? " " :
        " #{self.middle_name}") +
      self.first_name
  end

  def getFullKana
    self.kana_last_name +
      (self.kana_first_name.blank? ? " " :
        " #{self.kana_middle_name} ") +
      self.kana_first_name
  end

end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  enum cmn_status: {disabled: 0, enabled: 1}

end

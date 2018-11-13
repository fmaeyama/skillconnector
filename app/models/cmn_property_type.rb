class CmnPropertyType < ApplicationRecord
  enum property_datatype: {string: 0, date: 1, datetime: 2, integer: 3, file: 4, class_id: 5}
end

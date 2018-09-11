class EngineerStatusType < ApplicationRecord
	enum group: {disapprove:0, approved:1, causion:2}
	scope :enable,->{order('sort')}
	scope :active,->{where('disable_from < ?',datetime).order("sort")}
end

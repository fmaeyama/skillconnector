class EngineerHopeBusiness < ApplicationRecord
	belongs_to :engineer
	belongs_to :business_type,required:false
	belongs_to :skill,required:false
	enum hope_strength:{few:0,middle:1,high:2}

end

class Hat < ApplicationRecord
	belongs_to :hat_type
	belongs_to :hat_reference, polymorphic: true

	attr_accessor :level


	def self.hat_array(model, id)
		hat_array_obj = Array.new
		var = HatDecorator.new

		if id > 0
			focused = Hat.includes(:hat_type).where("hat_reference_type=", model.class_name+"_type").group_by{|ht| ht.hat_type.hat_level_id}
		end

		var.hat_levels.each do |hl|
			if focused.nil? || focused[h1.id].size == 0
				hat_obj = Hat.new
				hat_obj.level=hl.id
				hat_array_obj << hat_obj
			else
				hat_array_obj << fucused[hl.id]
			end
		end

		hat_array_obj

	end
end

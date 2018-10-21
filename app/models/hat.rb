class Hat < ApplicationRecord
	belongs_to :hat_type
	belongs_to :hat_reference, polymorphic: true

	attr_writer :init_level

	def level
		return self .hat_type.hat_level unless self .hat_type.nil?
		@init_level
	end

	def self.hats_hash(model, id, hat_decorator)
		hats_hash = Hash.new
		var = hat_decorator

		if id > 0
			focused = Hat.includes(:hat_type).where("hat_reference_type=", model.class_name+"_type").group_by{|ht| ht.hat_type.hat_level_id}
		end

		var.hat_levels.each do |hl_key, hl_val|
			hats_hash[hl_key] = Array.new
			unless focused.nil? || focused[hl_key].size == 0
				hats_hash[hl_key] << focused[hl_key]
			end
			hat_obj = Hat.new
			hat_obj.init_level =hl_val
			hats_hash[hl_key] << hat_obj
		end

		hats_hash

	end
end

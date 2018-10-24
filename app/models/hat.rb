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
		id = id.to_i
		if id > 0
			focused = model.find(id).hats.group_by{|ht| ht.hat_type.hat_level_id}
		end

		var.hat_levels.each do |hl_key, hl_val|
			hats_hash[hl_key] = Array.new
			unless focused.nil? || !focused.key?(hl_key) || focused[hl_key].size == 0
				hats_hash[hl_key].concat(focused[hl_key])
			end
			hat_obj = Hat.new
			hat_obj.init_level =hl_val
			hats_hash[hl_key] << hat_obj
		end

		hats_hash

	end

	def self.update_by_reference(model, id, params)
		params.require(:hat)

		params[:hat].each do |st_key, hat_arr|
			hat_arr.each do |key,hat|
				if (key[0,2] == "new") || (hat["id"].to_i==-1)
					next if hat["_destroy"].to_i == 1
					bus = model.find(id)
					@hat = bus.hats.create()
				else
					@hat = Hat.find(hat["id"])
					(@hat.destroy && next) if hat["_destroy"] == 1
					next if (hat["hat_type_id"] == @hat.hat_type_id.to_s) && (hat["memo"] == @hat.memo)
				end
				@hat.hat_type_id = hat["hat_type_id"].to_i
				@hat.memo = hat["memo"]
				@hat.save!
			end
		end
	end
end

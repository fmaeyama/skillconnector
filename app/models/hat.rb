class Hat < ApplicationRecord
	belongs_to :hat_type
	belongs_to :hat_reference, polymorphic: true

	attr_writer :init_level

	def level
		return self .hat_type.hat_level unless self .hat_type.nil?
		@init_level
	end

	# retunr Hash of {levels:{level_key:{array of hat}}, hat_supplement:{id:(), memo:()}}
	def self.hats_hash(model, id, hat_decorator)
		hats_hash = Hash.new
		hats_hash[:levels] = Hash.new
		var = hat_decorator
		id = id.to_i
		memo=nil
		if id > 0
			focused = model.find(id).hats.group_by{|ht| ht.hat_type.hat_level_id}
			memo = model.find(id).hat_supplement
		end
		if memo.nil?
			memo = HatSupplement.new
			memo.id = -1
		end
		hats_hash[:hat_supplement] = memo

		var.hat_levels.each do |hl_key, hl_val|
			hats_hash[:levels][hl_key] = Array.new
			unless focused.nil? || !focused.key?(hl_key) || focused[hl_key].size == 0
				hats_hash[:levels][hl_key].concat(focused[hl_key])
			else
				hat_obj = Hat.new
				hat_obj.init_level =hl_val
				hats_hash[:levels][hl_key] << hat_obj
			end
		end

		hats_hash

	end

	def self.hat_supplement_updater(hs_param)
		hs =　hs_param['id']==-1 ? HatSupplement.new : HatSupplement.find(hs_param['id'])
		hs.memo =　hs_param['memo']
		hs.save!
	end

	def self.update_by_reference(model, id, params, hat_decorator)
		params.require(:hat)

		params[:hat].each do |st_key, hat_arr|
			Hat.hat_supplement_updater(hat_arr) && next if st_key == 'hat_supplement'
			flg_level_saved = false
			hl=hat_decorator.hat_levels
			hl=hl[st_key.to_i]
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
				flg_level_saved = true
			end
			if !flg_level_saved && hl.required?
				raise ValidationError.new "hat_level #{hl.name} is required!"
			end

		end
	end
end

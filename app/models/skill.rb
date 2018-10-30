class Skill < ApplicationRecord
	belongs_to :skill_type
	belongs_to :skill_reference, polymorphic: true

	attr_writer :init_level

	def level
		return self.skill_type.skill_level unless self.skill_type.nil?
		@init_level
	end

	def self.skills_hash(model, id, hs_decorator, ret_hash)
		ret_hash[model] = Hash.new if ret_hash[model].nil?
		ret_hash[model][id] = Hash.new if ret_hash[model][id].nil?
		ret_hash[model][id][:levels] = Hash.new if ret_hash[model][id][:levels].nil?

		memo=nil
		id_i = id.to_i
		if id_i > 0
			focused = model.find(id_i).skills.group_by{|st| st.skill_type.skill_level_id}
			memo = model.find(id_i)
		end
		if memo.nil?
			memo = SkillSupplement.new
			memo.id = -1
		end
		ret_hash[model][id][:skill_supplement] = memo
		hs_decorator.skill_levels.each do |sl_key, sl_val|
			ret_hash[model][id][:levels][sl_key] = Array.new
			if focused.nil? || !focused.key?(sl_key) || focused[sl_key].size == 0
				skill_obj = Skill.new
				skill_obj.init_level = sl_val
				ret_hash[model][id][:levels][sl_key] << skill_obj
			else
				ret_hash[model][id][:levels][sl_key].concat(focused[sl_key])
			end
		end
		ret_hash
	end

end

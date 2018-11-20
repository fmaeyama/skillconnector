class Skill < ApplicationRecord
  belongs_to :skill_type
  belongs_to :skill_reference, polymorphic: true
  has_many :trained_histories, ->{order(evaluated_at: :desc)} ,as: :evaluation

  attr_writer :init_level

  def level
    return self.skill_type.skill_level unless self.skill_type.nil?
    @init_level
  end

  def trained_type
    nil if self.level.no_evaluation?
    nil if self.trained_histories.size == 0
    self.traind_histories[0]
  end

  def self.skills_hash(model, id, hs_decorator, ret_hash)
    ret_hash[model] = Hash.new if ret_hash[model].nil?
    ret_hash[model][id] = Hash.new if ret_hash[model][id].nil?
    ret_hash[model][id][:levels] = Hash.new if ret_hash[model][id][:levels].nil?

    memo = nil
    id_i = id.to_i
    if id_i > 0
      focused = model.find(id_i).skills.group_by {|st| st.skill_type.skill_level_id}
      memo = model.find(id_i).skill_supplement
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

  def self.skill_supplement_updater(model, id, ss_param)
    begin
      ss = (ss_param['id'].to_i == -1 ?
        model.find(id).build_skill_supplement :
        SkillSupplement.find(ss_param['id']))
    rescue ActiveRecord::RecordNotFound => e
      p e
      ss = model.find(id).build_skill_supplement
    end
    ss.memo = ss_param['memo']
    ss.save!
  end

  def self.update_by_reference(model, id, params, hs_decorator)
    params.require(:skill)
    params[:skill].each do |st_key, skill_arr|
      (Skill.skill_supplement_updater(model, id, skill_arr) && next) if st_key == 'skill_supplement'
      ## pp " ** update_by_reference #{hat_arr}"
      flg_level_saved = false
      sl = hs_decorator.skill_levels
      sl = sl[st_key.to_i]
      skill_arr.each do |key, skill|
        if (key[0, 2] == "new") || (skill["id"].to_i == -1)
          next if skill["_destroy"].to_i == 1
          next if skill["skill_type_id"].blank?
          parent_tbl = model.find(id)
          @skill = parent_tbl.skills.create
        else
          begin
            @skill = Skill.find(skill["id"])
          rescue ActiveRecord::RecordNotFound => ex
            p ex
            parent_tbl = model.find(id)
            @skill = parent_tbl.skills.create
          end
          (@skill.destroy && next) if skill["_destroy"] == 1
          flg_level_saved = true
          next if (skill["skill_type_id"] == @skill.skill_type_id.to_s) && (skill["memo"] == @skill.memo)
        end
        @skill.skill_type_id = skill["skill_type_id"].to_i
        @skill.memo = skill["memo"]
        # p "key : #{key} hat: #{hat}"
        pp @skill
        @skill.save!
        flg_level_saved = true
      end
      pp sl
      if !flg_level_saved && sl.required?
        raise ActiveModel::ValidationError.new "skill_level #{sl.name} is required!"
      end
    end
  end
end

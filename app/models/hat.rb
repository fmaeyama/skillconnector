class Hat < ApplicationRecord
  belongs_to :hat_type
  belongs_to :hat_reference, polymorphic: true

  attr_writer :init_level

  def level
    return self.hat_type.hat_level unless self.hat_type.nil?
    @init_level
  end

  # retunr Hash of {levels:{level_key:{array of hat}}, hat_supplement:{id:(), memo:()}}
  def self.hats_hash(model, id, hat_decorator, ret_hash)
    id_i = id.to_i
    var = hat_decorator

    ret_hash[model] = Hash.new if ret_hash[model].nil?
    ret_hash[model][id] = Hash.new if ret_hash[model][id].nil?
    ret_hash[model][id][:levels] = Hash.new if ret_hash[model][id][:levels].nil?
    memo = nil
    if id_i > 0
      focused = model.find(id_i).hats.group_by {|ht| ht.hat_type.hat_level_id}
      memo = model.find(id_i).hat_supplement
    end
    if memo.nil?
      memo = HatSupplement.new
      memo.id = -1
    end
    ret_hash[model][id][:hat_supplement] = memo

    var.hat_levels.each do |hl_key, hl_val|
      ret_hash[model][id][:levels][hl_key] = Array.new
      if focused.nil? || !focused.key?(hl_key) || focused[hl_key].size == 0
        hat_obj = Hat.new
        hat_obj.init_level = hl_val
        ret_hash[model][id][:levels][hl_key] << hat_obj
      else
        ret_hash[model][id][:levels][hl_key].concat(focused[hl_key])
      end
    end

    ret_hash

  end

  def self.hat_supplement_updater(model, id, hs_param)
    begin
      hs = (hs_param['id'].to_i == -1 ? model.find(id).build_hat_supplement : HatSupplement.find(hs_param['id'].to_i))
    rescue ActiveRecord::RecordNotFound => e
      #p e
      hs = HatSupplement.new
    end

    hs.memo = hs_param['memo']
    hs.save!
  end

  def self.update_by_reference(model, id, params, hs_decorator)
    params.require(:hat)
    params[:hat].each do |st_key, hat_arr|
      (Hat.hat_supplement_updater(model, id, hat_arr) && next) if st_key == 'hat_supplement'
      # p " ** update_by_reference #{hat_arr}"
      flg_level_saved = false
      hl = hs_decorator.hat_levels[st_key.to_i]
      hat_arr.each do |key, hat|
        if (key[0, 2] == "new") || (hat["id"].to_i == -1)
          next if hat["_destroy"].to_i == 1
          bus = model.find(id)
          @hat = bus.hats.create
        else
          begin
            @hat = Hat.find(hat["id"])
          rescue ActiveRecord::RecordNotFound => ex
            pp ex
            bus = model.find(id)
            @hat = bus.hats.create
          end
          (@hat.destroy && next) if hat["_destroy"] == 1
          flg_level_saved = true #変更がない場合もtrueにする
          next if (hat["hat_type_id"] == @hat.hat_type_id.to_s) && (hat["memo"] == @hat.memo)
        end
        @hat.hat_type_id = hat["hat_type_id"].to_i
        @hat.memo = hat["memo"]
        # p "key : #{key} hat: #{hat}"
        # p @hat
        @hat.save!
        flg_level_saved = true
      end
      if !flg_level_saved && hl.required?
        pp ' ** ValidationError hat.rb  **'
        pp hl
        raise ActiveModel::ValidationError.new "hat_level #{hl.name} is required!"
      end

    end
  end
end

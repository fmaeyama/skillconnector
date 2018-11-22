module SkillConnectsHelper
  def getParamCondVal(paramSet, key)
    return '' if paramSet.nil?
    return '' unless paramSet.key?(key)
    paramSet[key]
  end

  def helper_get_skill_strings(skills,skill_levels)
    skills_hash = skills.map{|row| [row.skill_type.skill_level_id, (row.memo.blank? ? row.skill_type.name : "#{row.skill_type.name}/#{row.memo}")]}
      .group_by{|arr| arr[0]}
    res = ""
    skill_levels.each do |sl_key, sl_val|
      res +=  "#{sl_val.name}:#{skills_hash[sl_key].map{|sk| sk[1]}.to_s} " unless skills_hash[sl_key].nil?
    end
    res
  end

  def helper_get_hat_strings(hats,hat_levels)
    hats_hash = hats.map{|row| [row.hat_type.hat_level_id, (row.memo.blank? ? row.hat_type.name : "#{row.hat_type.name}/#{row.memo}")]}.group_by{|arr| arr[0]}
    res = ""
    hat_levels.each do |hl_key, hl_val|
      res +=  "#{hl_val.name}:#{hats_hash[hl_key].map{|sk| sk[1]}.to_s} "
    end
    res
  end


  # from https://ruby-rails.hatenadiary.com/entry/20141208/1418018874
  # var must include [title]
  def link_to_add_fields(name, f, association, var)
    model_str = association.to_s.singularize
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    new_object.associate_to_hat_skill(var) if new_object.is_a?(HatSkillContainer)
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(model_str + '_input_parts', child: builder, var: var)
    end
    link_to(name, 'javascript:void(0)', class: model_str + "_add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def sc_helper_link_to_add_parts(part_title, part_name, *hash_params)
    id = SecureRandom.urlsafe_base64(8)
    temp_hash = {num: "new-#{id}"}
    temp_hash.merge!(hash_params[0])
    # pp "  ** debug sc_helper_link_to add parts "
    # pp temp_hash

    fields = render partial: "#{part_name}_input_tables", locals: temp_hash
    link_to(part_title, 'javascript:void(0)',
      class: "add_fields btn btn-secondary btn-lg",
      data: {id: id, model: part_name, fields: fields.gsub("\n", "")}) unless fields.nil?
  end
end

module SkillConnectsHelper
	def getParamCondVal(paramSet, key)
		return '' if paramSet.nil?
		return '' unless paramSet.key?(key)
		paramSet[key]
	end

	# from https://ruby-rails.hatenadiary.com/entry/20141208/1418018874
	# var must include [title]
	def link_to_add_fields(name, f, association, var)
		model_str = association.to_s.singularize
		new_object = f.object.send(association).klass.new
		id = new_object.object_id
		fields = f.fields_for(association, new_object, child_index:id) do |builder|
			render(model_str+'_input_parts', child:builder, var: var)
		end
		link_to(name, 'javascript:void(0)', class:model_str+"_add_fields", data: {id: id, fields: fields.gsub("\n", "")})
	end

	def sc_helper_link_to_add_parts(part_title, part_name, *hash_params)
		p " ** hash_params : "
		p  hash_params
		id = SecureRandom.urlsafe_base64(8)
		temp_hash = {num: "new-#{id}"}
		temp_hash.merge!(hash_params[0])
		fields = render partial: "#{part_name}_input_parts", locals:temp_hash
		link_to(part_title,'javascript:void(0)', class:part_name+"_add_fields btn btn-secondary", data:{id:id, fields:fields.gsub("\n","")})
	end
end

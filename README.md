# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

# 開発上のテンプレート

## jquery での要素追加ボタン

### engineer\new.html.haml

```
.sl-border-primary
	.col-12.career_holder
		%h3= Career.model_name.human
		= f.fields_for :careers do |career|
			-render "career_input_parts", child: career, var:@var
		.sl-row-rightAlign
			.col-12.align-content-end
				= link_to_add_fields t("cmn_sentence.add_form_title", model:Career.model_name.human), f, :careers, @var
```

### skill_connects_helper.rb

```
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

```


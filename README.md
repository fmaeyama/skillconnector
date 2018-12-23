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

## girdテンプレート

1. grid_info
2. define_selector

### 1. grid_info

columns(array of hash) 情報を取得する    

* 必須項目
	* field
### 2. define_selector

select項目とidのマッピングを定義する  
* where_chain
	* active recordを割り当てる
	* active recordで取得出来るfieldを元に表にグリッドしていく

* enum_field [hash of field and actual enum object]  
	* enum_fieldでfiledがセットされていたばあい、enum_fieldからidを取得し、grid_infoでfield指定されていたcolumnに代入する（grid_infoの対応するfieldにはid値(整数)が代入される  
* select_field hash of field  and display field  
	* id値をそのまま表示する fieldとselect_arrで定義されたval値を表示するdisplay_fieldを設定する  
	* select_fieldの中でも定義済みenumを利用するfield
* select_arr

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
# silverion 関数テンプレート

## search res modalからのjs呼出
= link_to('name', 'javascript:void(0);',onclick: “console.log(’test')")  

## search_by_post (Application::createConditionの呼出)

例：(business_controller.rb)  
```
    def search_by_post(var)
      cond_list = {name: CondEnum::LIKE, business_type_id: CondEnum::EQ}
      free_word = {keyword: [:description, :welcome]}
      cond_set = self.createCondition(params, cond_list, free_word)
      var.search_cond = cond_set[:cond_param]
      Business.where(cond_set[:cond_arr])
    end
```  

## d-flex

* ml-auto 左側にマージンを自動で入れて、その要素だけ右詰する  
* mr-auto 右側にマージンを自動で入れて、その要素だけ左詰にする  
## ActiveRecord

### join and where not

(proposal.rb)  
```
  def other_offers
    Offer.select("offers.*","businesses.name as business_name","businesses.id as business_id", "proposals.id as proposalid").joins(:business).joins(:proposals).where({proposals: {engineer_id: self.engineer_id}}).where.not({proposals: {id: self.id}})
  end
```  
#id体系  

*   
* 業務：BNS#{"%05d" % offer.business.id}  
* 要員：ENG#{"%05d" % engineer.id}  


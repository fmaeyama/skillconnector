class BusinessesController < ApplicationController

	def initialize
		super
		@var = BusinessDecorator.new
	end

	def index
		@var.title = t('cmn_sentence.listTitle', model: @var.model_name)
		if request.post?
			cond_list = {name: CondEnum::LIKE, business_type_id: CondEnum::EQ}
			free_word = {keyword: [:descriptions, :welcome]}
			condSet = self.createCondition(params, cond_list, free_word)
			@businesses = Business.where(condSet[:cond_arr])
			@var.search_cond = condSet[:cond_param]
		end

		@businesses = Business.all if @business.nil?
		@var.view_counter = @businesses.count
	end

	def new
		@var.title = t('cmn_sentence.newTitle', @var.model_name)
		@business = Business.new
	end

	def edit_own

	end

	def contact_list

	end

end

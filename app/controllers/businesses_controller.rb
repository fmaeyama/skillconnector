class BusinessesController < ApplicationController
	include BusinessesHelper

	def index
		@var = BusinessDecorator
		@var.title = t 'cmn_sentence.listTitle', model:t('cmn_dict.business')
		@businesses = Business.all
		@res_cnt = @businesses.count
	end

	def new
		@var = BusinessDecorator
		@var.title = t 'cmn_sentence.newTitle', model:t('cmn_dict.business')
		@business = Business.new
	end

	def edit_own

	end

	def contact_list

	end

end

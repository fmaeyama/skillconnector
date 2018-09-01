class BusinessesController < ApplicationController
	include BusinessesHelper

	def index
		@businesses = Business.all
		@res_cnt = @businesses.count
	end

	def new
		@var = BusinessParams.new
		@var.title = '新規事業所作成'
		@business = Business.new
	end

	def edit_own

	end

	def contact_list

	end

end

class BusinessViewModel
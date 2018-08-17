class OfficeController < ApplicationController

	# 一覧表示
	def index

	  if request.post? then
			cond_list = [name: CondEnum::LIKE, name_kana: CondEnum::LIKE,
			               long_name: CondEnum::LIKE, long_name_kana: CondEnum::LIKE, parent_id: 'equal', office_status_id: 'in']
			cond = self.createCondition(params,cond_list)
			# find by name: like
			@office = Office.where(cond)
	  else
			@office = Office.all
	  end

		@office = Office.all

	end

	# 一覧表表示
	def list

	end

	# 詳細編集
	def new
		@officeStatuses = OfficeStatus.all
	end

	# 詳細編集
	def edit
		@officeStatuses = OfficeStatus.all
	end

end

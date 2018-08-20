class OfficeController < ApplicationController

	# 一覧表示
	def index

	  if request.post? then
			cond_list = [name: CondEnum::LIKE, name_kana: CondEnum::LIKE,
			               long_name: CondEnum::LIKE, long_name_kana: CondEnum::LIKE,
						parent_id: 'equal', office_status_id: 'in']
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
		@officeType = OfficeType.all
		@office = Office.new
		if request.post? then
			@office.attributes=officeParams

			respond_to do |format|
				if @office.save!
					format.html {redirect_to({action: 'edit', id:@office.id}, notice: 'Successfully created')}
					format.json {render :show, status: :created, location: @office}
				else
					format.html {render :new, notice: 'error'}
					format.json {render json:format, status: :unprocessable_entity}
				end
			end
		else
			@office.office_status_id=OfficeStatus.select(:id).first(1)
			@office.office_type_id=OfficeType.select(:id).first(1)
		end
	end

	# 詳細編集
	def edit
		@officeStatuses = OfficeStatus.all
		@officeType = OfficeType.all
		@office=Office.find(params[:id])
		render action: 'new'
	end

	private
	def officeParams
		params.require(:office).permit(
			:id,  :office_status_id, :cd, :office_type_id, :name,  :name_kana,  :long_name,  :long_name_kana
		)
	end


end

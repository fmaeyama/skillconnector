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

			begin
				Office.transaction do
					@office.attributes = officeParams
					@address = Address.new
					@contact = Contact.new
					@address.attributes = Address.addressParams(params[:office], :primary_address)
					@address.about_this = 'Primary Address of ' + @office.cd
					@address.save!
				end
					@contact.attributes = Contact.permitParams(params[:office]  , :primary_contact)
					@contact.save!
					@office.primary_contact_id = @contact.id
					@office.primary_address_id = @address.id
					@office.save!
				respond_to do |format|
					format.html {redirect_to({action: 'edit', id: @office.id}, notice: 'Successfully created')}
					format.json {render :show, status: :created, location: @office}
				end
			# rescue => e
			# 	str = e.message
			# 	respond_to do |format|
			# 		format.html {render :new, notice: str}
			# 		format.json {render json: format, status: :unprocessable_entity}
			# 	end
			end

		else
			@office.office_status_id=OfficeStatus.select(:id).first(1)
			@office.office_type_id=OfficeType.select(:id).first(1)
			@office.primary_address = Address.new
			@office.primary_contact = Contact.new
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
			:id,  :office_status_id, :cd, :office_type_id, :name,  :name_kana,  :long_name,  :long_name_kana,
			:parent_id, :privary_address_id,  :primary_contact_id,
			# primary_contact: [:contact_name, :contact_kana, :title,
			# 	:contact_type, :contact_value],
			# primary_address: [:id,:postal_code,:prefecture_id,:address,:building,:about_this],
			:primary_parent
		)
	end



end

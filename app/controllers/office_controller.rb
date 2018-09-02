class OfficeController < ApplicationController

	def initialize
		super
		@var = OfficeDecorator.new
	end

	# 一覧表示
	def index
		@var.title = t('cmn_sentence.listTitle', model: @var.model_name)
		if request.post? then
			cond_list = {name: CondEnum::LIKE, cd: CondEnum::EQ,
				long_name: CondEnum::LIKE, long_name_kana: CondEnum::LIKE,
				parent_id: CondEnum::EQ, office_status_id: CondEnum::IN}
			free_word = {keyword: [:name,  :cd,  :long_name,  :long_name_kana]}
			@offices = self.createCondition(Office, params, cond_list, free_word)
			# find by name: like
			@offices.order('cd')
		end

		if (@offices.nil?) then
			@offices = Office.all
		end

		@var.view_count = @offices.count

	end

	# 一覧表表示
	def list
		@var.title = t('cmn_sentence.listTitle', model: @var.model_name)
		@offices = Office.all

		@var.view_count = @offices.count

	end

	# 詳細編集
	def new
		@officeStatuses = OfficeStatus.all
		@officeType = OfficeType.all
		@office = Office.new
		@var.title = t('cmn_sentence.newTitle', model: @var.model_name)
		if request.post? then

			begin
				Office.transaction do
					@office.attributes = officeParams
					@address = Address.new
					@contact = Contact.new
					@address.attributes = Address.addressParams(params[:office], :primary_address_attributes)
					@address.about_this = 'Primary Address of ' + @office.cd
					@address.save!
				end
				@contact.attributes = Contact.permitParams(params[:office], :primary_contact_attributes)
				@contact.save!
				@office.primary_contact_id = @contact.id
				@office.primary_address_id = @address.id
				@office.save!
				respond_to do |format|
					format.html {redirect_to({action: 'edit', id: @office.id}, notice: 'Successfully created')}
					format.json {render :show, status: :created, location: @office}
				end
			rescue => e
				flash.now[:alert] = e.message
				respond_to do |format|
					format.html {render 'new'}
					format.json {render json: format, status: :unprocessable_entity}
				end
			end

		else
			@office.office_status_id = OfficeStatus.select(:id).first(1)
			@office.office_type_id = OfficeType.select(:id).first(1)
			@office.primary_address = Address.new
			@office.primary_contact = Contact.new
		end
	end

	# 詳細編集
	def edit
		@title = t('cmn_dict.office') + '＃' + params[:id]
		@officeStatuses = OfficeStatus.all
		@officeType = OfficeType.all
		@office = Office.find(params[:id])
		render action: 'new'
	end

	private

		def officeParams
			params.require(:office).permit(
				:id, :office_status_id, :cd, :office_type_id, :name, :name_kana, :long_name, :long_name_kana,
				:parent_id, :privary_address_id, :primary_contact_id,
				# primary_contact: [:contact_name, :contact_kana, :title,
				# 	:contact_type, :contact_value],
				# primary_address: [:id,:postal_code,:prefecture_id,:address,:building,:about_this],
				:primary_parent
			)
		end


end

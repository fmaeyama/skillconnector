class StaffController < ApplicationController
	def initialize
		super
		@var = StaffDecorator.new
		@var.link = {
			t("cmn_sentence.listTitle", model:Staff.model_name.human) => {controller:"staff", action:"index"},
			t("cmn_sentence.newTitle", model:Staff.model_name.human) => {controller:"staff", action:"new"}
		}
	end

	def index
		@var.title = t("cmn_sentence.listTitle",model:Staff.model_name.human)
		if request.post?
			cond_list = {name: CondEnum::LIKE}
			free_word = {keyword:[:history]}
			cond_set = self.createCondition(params, cond_list, free_word)
			@staffs = Staff.where(cond_set[:cond_arr])
			@var.search_cond = cond_set[:cond_param]
		else
			@var.search_cond = nil
		end
		@staffs = Staff.all if @var.search_cond.nil?
		@var.view_count = @staffs.count
	end

	def new
		@var.title=t("cmn_sentence.newTitle", model:Staff.model_name.human)
		@var.mode="new"
		@staff=Staff.new
	end

	def create
		@staff=Staff.new
		save_staff(params)
		respond_to do |format|
			format.html {redirect_to action: "edit", id: @staff.id}
			format.json {render :show, status: :created, location: @staff}
		end
	rescue => e
		raise e if Rails.env == 'development'
		respond_to do |format|
			format.html {render 'new'}
			format.json {render json: format, status: :unprocessable_entity}
		end
	end

	def edit
		@var.title = t('cmn_sentence.editTitle',model:Staff.model_name.human,id:params[:id])
		@var.mode=params[:id]
		@staff = Staff.find(params[:id])
		render action:"new"
	end


	def update
		@staff = Staff.find(params[:id])
		save_staff(params)
		respond_to do |format|
			format.html {redirect_to action: "edit", id: @staff.id}
			format.json {render :show, status: :created, location: @staff}
		end
	rescue => e
		raise e if Rails.env == 'development'
		respond_to do |format|
			format.html {redirect_to action: "edit", id: params[:id]}
			format.json {render json: format, status: :unprocessable_entity}
		end
	end
	private
	def save_staff(params)
		Staff.transaction do
			@staff.attributes=Staff.parameters(params,:staff)
			@staff.save!
		end
	end

end

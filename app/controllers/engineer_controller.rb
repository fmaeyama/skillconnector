class EngineerController < ApplicationController

	def initialize
		super
		@var = EngineerDecorator.new
		@var.link = {
			I18n.t("cmn_sentence.listTitle", model:Engineer.model_name.human)=>{controller:"engineer", action:"index"},
			I18n.t("cmn_sentence.newTitle", model:Engineer.model_name.human)=>{controller:"engineer", action:"new"}
		}
	end

	def index
		@var.title = t('cmn_sentence.listTitle',model:Engineer.model_name.human)
		if request.post?
			cond_list = {cd: CondEnum::LIKE}
			free_word = {keyword: [:eng_cd, :person_info, ]}
			cond_set = self.createCondition(params, cond_list,free_word)
			@engineers = Engineer.where(cond_set[:cond_arr])
			@var.search_cond = cond_set[:cond_param]
		else
			@var.search_cond = nil
		end

		@engineers = Engineer.all if @var.search_cond.nil?
		@var.view_count = @engineers.count
	end

	def new
		@var.title=t("cmn_sentence.newTitle",model:Engineer.model_name.human)
		@var.mode="new"
		@engineer=Engineer.new
	end

	def create
		@engineer=Engineer.new
		save_engineer(params)
		respond_to do |format|
			format.html {redirect_to action: "edit", id: @engineer.id}
			format.json {render :show, status: :created, location: @engineer}
		end
	rescue => e
		raise e if Rails.env == 'development'
		respond_to do |format|
			format.html {render 'new'}
			format.json {render json: format, status: :unprocessable_entity}
		end
	end

	def show

	end

	def edit
		@var.title = I18n.t("cmn_sentence.editTitle",
			model:Engineer.model_name.human,
			id:params[:id]
		)
		@var.mode = params[:id]
		@engineer = Engineer.find(params[:id])
		render action: "new"

	end

	def search
		@var.title =t("cmn_sentence.searchResult",model:Engineer.model_name.human)
		@var.mode = params[:offer_id]
		cond_list = {cd: CondEnum::LIKE}
		free_word = {keyword: [:eng_cd ]}
		cond_set = self.createCondition(params, cond_list,free_word)
		@engineers = Engineer.where(cond_set[:cond_arr])
		@var.search_cond = cond_set[:cond_param]
		if @engineers.size == 0
			@var.modal_dlg_message = t("cmn_sentence.noResult")
			@engineers = Engineer.all
		end
	rescue => e
		@var.modal_dlg_message = e.message
	end

	def update
		@engineer = Engineer.find(params[:id])
		save_engineer(params)
		respond_to do |format|
			format.html {redirect_to action: "edit", id: params[:id]}
			format.json {render :show, status: :created, location: @engineer}
		end
	rescue => e
		raise e if Rails.env == 'development'
		respond_to do |format|
			format.html {redirect_to action: "edit", id: params[:id]}
			format.json {render json: format, status: :unprocessable_entity}
		end
	end

	def destroy

	end

	private

	def save_engineer(params)
		Engineer.transaction do
			@engineer.attributes = Engineer.parameters(params, :engineer)
			@engineer.save!
		end
	end
end

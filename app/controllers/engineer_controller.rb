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
		@var.title = t('cmn_sentence.newTitle',model:Engineer.model_name.human)
		if request.post?
			cond_list = {cd: CondEnum::LIKE}
			free_word = {keyword: [:eng_cd, :person_info, ]}
			cond_set = self.createCondition(params, cond_list,free_word)
			@engineers = Engineer.where(cond_set[:cond_arr])
			@var.search_cond = cond_set[:cond_param]
		else
			@var.search_cond = nil
		end

		@engineers = Engineer.all if @engineers.nil?
		@var.view_count = @engineers.count
	end

	def new
		@var.title=t("cmn_sentence.newTitle",model:Engineer.model_name.human)
		@engineer=Engineer.new
		@engineer.init_new_instance(params)
	end

	def create
		insert_new_engineer(params)
		begin

		rescue =>e
		end
	end

	def show

	end

	def edit
		@var.title = I18n.t("cmn_sentence.editTitle",model:Engineer.model_name.human)
		@engineer = Engineer.find(prams[:id])
		render action: "new"

	end

	def update

	end

	def destroy

	end

	private

	def insert_new_engineer(params)
		begin
			Engineer.transaction do
				@engineer.attributes = Engineer.engineer_params(params, :engineer)
				@engineer.save!
				respond_to do |format|
					format.html {redirect_to(action: 'edit', id: @engineer.id)}
					format.json {render :show, status: :created, location: @engineer}
				end
			end
			rescue => e
				raise e if Rails.env == 'developmment'
				respond_to do |format|
					format.html {render 'new'}
					format.json {render json: format, status: :unprocessable_entity}
				end

		end
	end
end

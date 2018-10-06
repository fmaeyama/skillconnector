class ProposalController < ApplicationController

	def initialize
		super
		@var = ProposalDecorator.new
		@var.link = {
			I18n.t("cmn_sentence.listTitle", model:Proposal.model_name.human)=>{controller:"proposal", action:"index"},
			I18n.t("cmn_sentence.newTitle", model:Proposal.model_name.human)=>{controller:"proposal", action:"new"},
			I18n.t("cmn_sentence.listTitle", model:Engineer.model_name.human)=>{controller:"engineer", action:"index"},
			I18n.t("cmn_sentence.listTitle", model:Office.model_name.human)=>{controller:"office", action:"index"},
			I18n.t('cmn_sentence.listTitle',model: Business.model_name.human) => {controller:'business', action:'index'},
			I18n.t('cmn_sentence.listTitle', model: Offer.model_name.human) => {controller:'offer', action: 'index'}
		}
	end

	def index
		@var.title = t('cmn_sentence.listTitle',model:Proposal.model_name.human)
		if request.post?
			cond_list = {cd: CondEnum::LIKE}
			free_word = {keyword: [:eng_cd, :person_info ]}
			cond_set = self.createCondition(params, cond_list,free_word)
			@engineers = Proposal.where(cond_set[:cond_arr])
			@var.search_cond = cond_set[:cond_param]
		else
			@var.search_cond = nil
		end

		@proposals = Proposal.all if @var.search_cond.nil?
		@var.view_count = @proposals.count
	end

	def new
		@var.title=t("cmn_sentence.newTitle",model:Proposal.model_name.human)
		@var.mode="new"
		@proposal=Proposal.new
	end

	def create
		@proposal=Proposal.new
		save_proposal(params)
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

	def edit
		@var.title = I18n.t("cmn_sentence.editTitle",
			model:Proposal.model_name.human,
			id:params[:id]
		)
		@var.mode = params[:id]
		@proposal = Proposal.find(params[:id])
		render action: "new"

	end

	def search
		@var.title =t("cmn_sentence.searchResult",model:Proposal.model_name.human)
		cond_list = {cd: CondEnum::LIKE}
		free_word = {keyword: [:eng_cd ]}
		cond_set = self.createCondition(params, cond_list,free_word)
		@proposals = Proposal.where(cond_set[:cond_arr])
		@var.search_cond = cond_set[:cond_param]
		if @proposals.size == 0
			@var.modal_dlg_message = t("cmn_sentence.noResult")
			@proposals = Proposal.all
		end
	rescue => e
		@var.modal_dlg_message = e.message
	end

	def update
		@proposal = Proposal.find(params[:id])
		save_proposal(params)
		respond_to do |format|
			format.html {redirect_to action: "edit", id: params[:id]}
			format.json {render :show, status: :created, location: @proposal}
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

		def save_proposal(params)
			Engineer.transaction do
				@proposal.attributes = Proposal.parameters(params, :proposal)
				@proposal.save!
			end
		end



end

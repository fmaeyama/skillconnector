class OfferController < ApplicationController

	def initialize
		super
		@var = OfferDecorator.new
		@var.link = {
			I18n.t("cmn_sentence.listTitle", model:Offer.model_name.human)=>{controller:"offer", action:"index"},
			I18n.t("cmn_sentence.newTitle", model:Engineer.model_name.human)=>{controller:"offer", action:"new"}
		}
	end

	def index
		@var.title = t('cmn_sentence.listTitle',model:Offer.model_name.human)
		if request.post?
			cond_list = {cd: CondEnum::LIKE}
			free_word = {keyword: [:eng_cd, :person_info, ]}
			cond_set = self.createCondition(params, cond_list,free_word)
			@offers = Offer.where(cond_set[:cond_arr])
			@var.search_cond = cond_set[:cond_param]
		else
			@var.search_cond = nil
		end

		@offers = Offer.all if @var.search_cond.nil?
		@var.view_count = @offers.count
	end

	def new
		@var.title=t("cmn_sentence.newTitle",model:Offer.model_name.human)
		@var.mode="new"
		bus_id = params[:business_id].blank? ? Business.select(:id).first(1) : params[:business_id]
		@offer=Offer.new(business_id: bus_id)
		@offer.business = Business.find(bus_id)[0]
	end

	def create
		@engineer=Offer.new
		save_engineer(params)
		respond_to do |format|
			format.html {redirect_to action: "edit", id: @offer.id}
			format.json {render :show, status: :created, location: @offer}
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
												model:Offer.model_name.human,
												id:params[:id]
		)
		@var.mode = params[:id]
		@offer = Offer.find(params[:id])
		render action: "new"

	end

	def update
		@offer = Offer.find(params[:id])
		save_offer(params)
		respond_to do |format|
			format.html {redirect_to action: "edit", id: params[:id]}
			format.json {render :show, status: :created, location: @offer}
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

	def save_offer(params)
		Offer.transaction do
			@offer.attributes = Offer.parameters(params, :offer)
			@offer.save!
		end
	end

end

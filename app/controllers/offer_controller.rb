class OfferController < ApplicationController

  def initialize
    super
    @var = OfferDecorator.new
    @var.link = {
      I18n.t("cmn_sentence.listTitle", model: Offer.model_name.human) => {controller: "offer", action: "index"},
      I18n.t("cmn_sentence.newTitle", model: Engineer.model_name.human) => {controller: "offer", action: "new"},
      I18n.t('cmn_sentence.listTitle', model: Office.model_name.human) => {controller: 'office', action: 'index'},
      I18n.t('cmn_sentence.listTitle', model: Business.model_name.human) => {controller: 'business', action: 'index'},
      I18n.t('cmn_sentence.listTitle', model: '表編集') => {controller: 'grid', action: 'index'}
    }
  end

  def index
    @var.title = t('cmn_sentence.listTitle', model: Offer.model_name.human)
    if request.post?
      cond_list = {cd: CondEnum::LIKE}
      free_word = {keyword: [:eng_cd, :person_info,]}
      cond_set = self.createCondition(params, cond_list, free_word)
      @offers = Offer.where(cond_set[:cond_arr])
      @var.search_cond = cond_set[:cond_param]
    else
      @var.search_cond = nil
    end

    @offers = Offer.all if @var.search_cond.nil?
    @var.view_count = @offers.count
  end

  def new
    @var.title = t("cmn_sentence.newTitle", model: Offer.model_name.human)
    @var.mode = "new"
    bus_id = params[:business_id].blank? ? -1 : params[:business_id]
    @offer = Offer.new(business_id: bus_id)
  end

  def create
    @offer = Offer.new
    save_offer(params)
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
      model: Offer.model_name.human,
      id: params[:id]
    )
    @var.mode = params[:id]
    @offer = Offer.find(params[:id])
    @var.offer_object = @offer
    render "new"

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
    @offer = Offer.find(params[:id])
    @offer.destroy!
    #特殊なケースなのでまずはエラーハンドリングしない
    render "index"
  end

  private

    def save_offer(params)
      Offer.transaction do
        @offer.attributes = Offer.parameters(params, :offer)
        @offer.save!
      end
    end

end

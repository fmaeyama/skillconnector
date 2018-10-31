class GridController < ApplicationController
	def initialize
		super
		@var = GridDecorator.new
		@var.link = {
			I18n.t("cmn_sentence.listTitle", model:Engineer.model_name.human)=>{controller:"engineer", action:"index"},
			I18n.t("cmn_sentence.newTitle", model:Engineer.model_name.human)=>{controller:"engineer", action:"new"},
			I18n.t("cmn_sentence.listTitle", model:Office.model_name.human)=>{controller:"office", action:"index"},
			I18n.t('cmn_sentence.listTitle',model: Business.model_name.human) => {controller:'business', action:'index'},
			I18n.t('cmn_sentence.listTitle', model: Offer.model_name.human) => {controller:'offer', action: 'index'}
		}
	end

	def hat_levels
		@var.title = HatLevel.model_name.human
		render layout:"grid_content"
	end
end

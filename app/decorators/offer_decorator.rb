class OfferDecorator < SkillConnectDecorator
	delegate_all
	attr_reader :offer_statuses

	def initialize
		self.model_name = Offer.model_name.human
		@offer_statuses = OfferStatus.enable

	end


end

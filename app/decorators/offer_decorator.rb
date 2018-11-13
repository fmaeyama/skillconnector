class OfferDecorator < SkillConnectDecorator
	delegate_all
	attr_reader :offer_statuses
	attr_accessor :offer_object

	def initialize
		self.model_name = Offer.model_name.human
		@offer_statuses = OfferStatus.enable
		@offer_object = nil

	end


end

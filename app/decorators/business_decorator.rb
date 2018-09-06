class BusinessDecorator < SkillConnectDecorator
	delegate_all
	attr_reader :business_types, :business_statuses

	def initialize
		@business_types = BusinessType.active
		@business_statuses = BusinessStatus.active
		self.model_name = I18n.t('cmn_dict.business')
	end
end

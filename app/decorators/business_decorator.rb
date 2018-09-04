class BusinessDecorator < SkillConnectDecorator
	delegate_all

	attr_writer :business_types, :business_status
	def initialize
		super
		self.model_name = t('cmn_dict.business')
		@business_type = BusinessType.all
		@business_status = BusinessStatus.all
	end
end

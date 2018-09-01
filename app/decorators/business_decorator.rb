class BusinessDecorator < SkillConnectDecorator
	delegate_all

	def initialize
		self.model_name = t('cmn_dict.business')
	end
end

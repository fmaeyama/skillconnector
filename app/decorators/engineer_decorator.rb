class EngineerDecorator < SkillConnectDecorator
	delegate_all

	attr_reader :engineer_registration_types, :engineer_status_types
	def initialize
		self.model_name = Engineer.model_name.human
		@engineer_registration_types = EngineerRegistrationType.enable
		@engineer_status_types = EngineerStatusType.enable
	end

end

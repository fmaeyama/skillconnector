class EngineerDecorator < SkillConnectDecorator
	delegate_all

	attr_reader :engineer_registration_types, :engineer_status_types
	def initialize
		self.model_name = Engineer.model_name.human
		self.engineer_registration_types = EngineerRegistrationType.enable
		self.engineer_status_types = EngineerStatusType.enable
	end

end

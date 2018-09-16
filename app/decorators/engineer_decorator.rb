class EngineerDecorator < SkillConnectDecorator
	delegate_all

	attr_reader :engineer_registration_types, :engineer_status_types, :skills
	def initialize
		self.model_name = Engineer.model_name.human
		@engineer_registration_types = EngineerRegistrationType.enable
		@engineer_status_types = EngineerStatusType.enable
		@skills = Skill.enable
	end

end

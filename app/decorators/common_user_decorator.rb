class CommonUserDecorator < SkillConnectDecorator
	delegate_all

	attr_reader :privileges

	def initialize
		self .model_name=User.model_name.human
		@privileges = PrivilegeGroup.all
	end

end

class StaffDecorator < SkillConnectDecorator
	delegate_all

	def initialize
		self.model_name = Staff.model_name.human
	end

end

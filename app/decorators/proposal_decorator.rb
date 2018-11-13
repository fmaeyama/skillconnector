class ProposalDecorator < SkillConnectDecorator
	delegate_all

	def initialize
		self.model_name = Proposal.model_name.human
	end

end

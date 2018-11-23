class ProposalDecorator < SkillConnectDecorator
  delegate_all
	attr_accessor :contacts

  def initialize
    self.model_name = Proposal.model_name.human
  end

end

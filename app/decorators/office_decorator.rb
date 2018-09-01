class OfficeDecorator < SkillConnectDecorator
  delegate_all

  attr_reader :officeStatus, :officeType

  def initialize
    @officeStatus = OfficeStatus.active
    @officeType = OfficeType.active
    self.model_name = t('cmn_dict.office')

  end
end

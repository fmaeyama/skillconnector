class OfficeDecorator < SkillConnectDecorator
  delegate_all

  attr_reader :office_statuses, :office_types

  def initialize
    @office_statuses = OfficeStatus.active
    @office_types = OfficeType.active
    self.model_name = I18n.t('cmn_dict.office')
  end
end

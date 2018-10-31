class GridDecorator < SkillConnectDecorator
  delegate_all

  def initialize
    super
    self.model_name = I18n.t('cmn_dict.business')
  end
end

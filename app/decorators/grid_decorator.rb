class GridDecorator < SkillConnectDecorator
  delegate_all
  attr_accessor :columns, :data, :table_options, :select_arr, :notice


  def initialize
    super
    @columns = Array.new
    @data = Array.new
    @select_arr = Hash.new
    @notice = nil
    self.model_name = I18n.t('cmn_dict.business')
  end
end

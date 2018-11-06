class GridDecorator < SkillConnectDecorator
    delegate_all
    attr_accessor :columns, :data, :table_options


    def initialize
        super
        @columns = Array.new
        @data = Array.new
        self.model_name = I18n.t('cmn_dict.business')
    end
end

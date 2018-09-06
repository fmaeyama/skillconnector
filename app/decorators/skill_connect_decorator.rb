class SkillConnectDecorator < Draper::Decorator
  delegate_all
  attr_accessor :title, :view_count, :model_name, :search_cond
end

class ModalSCDecorator < Draper::Decorator
  delegate_all
  attr_accessor :title, :main_object
end
class SkillConnectDecorator < Draper::Decorator
  delegate_all
  attr_accessor :title, :view_count, :model_name, :search_cond
end

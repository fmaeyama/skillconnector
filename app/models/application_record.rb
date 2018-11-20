require 'grid_controller'

module HatSkillContainer
  def associate_to_hat_skill(hs_decorator)
    raise Exception.new "hs_decorator should be a instance of SkillHatContainer" unless hs_decorator.is_a?(SkillHatContainer)

  end

end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  enum cmn_status: {disabled: 0, enabled: 1}
  enum cmn_group: {disapprove: 0, approved: 1, causion: 2}
  enum cmn_span_type: {day:0, month:1, year:2, open:3}
  enum cmn_evaluation_type: {no_evaluation:0, trained_type:1}
end

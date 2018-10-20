class HatDecorator < ApplicationDecorator
  delegate_all

  attr_readonly :hat_types, :hat_levels

  def initialize
    @hat_levels = Hash[HatLevel.all.map{|hl| [hl.id, hl]}]
    @hat_types = HatType.enable.group_by{|ht| ht.hat_level_id}
  end


  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end

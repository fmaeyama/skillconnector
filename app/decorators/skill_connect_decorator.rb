class UnexpectedCallerError < Exception::StandardError

end

module SkillHatContainer
  attr_reader :hats_hashes, :hat_types, :hat_levels, :skill_types, :skill_levels,
    :skills_hashes, :trained_types, :alert

  def initialize
    @hat_levels = Hash[HatLevel.all.map {|hl| [hl.id, hl]}]
    @hat_types = HatType.enable.group_by {|ht| ht.hat_level_id}
    @skill_levels = Hash[SkillLevel.all.map {|sl| [sl.id, sl]}]
    @skill_types = SkillType.enable.group_by {|st| st.skill_level_id}
    @trained_types = TrainedType.active.map {|tt| [I18n.t("trained_type.#{tt.name}"),tt.id]}.to_h
    @hats_hashes = Hash.new
    @skills_hashes = Hash.new
  end

  def build_hats_hash(model, id)
    Hat.hats_hash model, id.to_s, self, @hats_hashes
  end

  def build_skills_hash(model, id)
    Skill.skills_hash model, id.to_s, self, @skills_hashes
  end

  def update_by_reference(model, id, params)
    Hat.update_by_reference model, id.to_s, params[(params.key?("#{model.name}#{id}")?"#{model.name}#{id}":"#{model.name}-1")], self
    Skill.update_by_reference model, id.to_s, params[(params.key?("#{model.name}#{id}")?"#{model.name}#{id}":"#{model.name}-1")], self
  end

  def hats_hash(model, id)
    raise UnexpectedCallerError.new "initialize error : build_hats_hash has not called yet" if @hats_hashes.nil?
    raise UnexpectedCallerError.new "hats_hash not defined for model : #{model}/#{id} #{pp @hats_hashes}" unless (@hats_hashes.key?(model) && @hats_hashes[model].key?(id.to_s))
    @hats_hashes[model][id.to_s]
  end

  def skills_hash(model, id)
    raise UnexpectedCallerError.new "initialize error : build_skills_hash has not called yet" if @skills_hashes.nil?
    raise UnexpectedCallerError.new "skills_hash not defined for model : #{model} (#{id}) #{pp @skills_hashes}" unless (@skills_hashes.key?(model) && @skills_hashes[model].key?(id.to_s))
    @skills_hashes[model][id.to_s]

  end
end

class SkillConnectDecorator < Draper::Decorator
  delegate_all
  attr_accessor :title, :modal_title, :view_count, :model_name, :search_cond, :link, :mode, :modal_dlg_message

  def initialize
    get_authorized_link
    @title = "silverion decorator!"
    @modal_title = "silverion decorator"
  end

  def get_authorized_link
    add_model_to_link(Office)
    add_model_to_link(Business)
    add_model_to_link(Offer)
    add_model_to_link(Engineer)
    add_model_to_link(Proposal)
  end

  def add_model_to_link(model)
    @link = {} if @link.nil?
    @link.merge(
      {
        I18n.t("cmn_sentence.listTitle", model: model.model_name.human) => {controller: "office", action: "index"},
        I18n.t("cmn_sentence.newTitle", model: model.model_name.human) => {controller: "office", action: "new"},
      }
    )

  end

  def nav_menu
    return "" if self.link.blank?
    h.content_tag(:ul, class: "nav nav-tabs") do
      self.link.each do |title, menu|
        h.concat(h.content_tag(:li, class: "nav-item mx-2") do
          h.concat ((title == self.title) ? h.link_to(title, menu, class: "nav-link active") : h.link_to(title, menu, class: "nav-link text-white"))
        end)
      end
    end
  end

end

class ModalSCDecorator < Draper::Decorator
  delegate_all
  attr_accessor :title, :main_object
end
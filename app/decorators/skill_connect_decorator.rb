class UnexpectedCallerError < Exception::StandardError

end

module SkillHatContainer
	attr_reader :hats_hashes, :hat_types, :hat_levels, :skill_types, :skill_levels, :skills_hash

	def initialize
		@hat_levels = Hash[HatLevel.all.map{|hl| [hl.id, hl]}]
		@hat_types = HatType.enable.group_by{|ht| ht.hat_level_id}
	end

	def build_hats_hash(model,id)
		@hats_hashes=Hat.hats_hash(model,id,self)
	end

	def hats_hash(model)
		raise UnexpectedCallerError "initialize error : build_hats_hash has not called yet" if @hats_hashes.nil?
		raise UnexpectedCallerError "hats_hash not defined for model : #{model}" unless @hats_hashes.key?(model)
		@hats_hashes[model]
	end
end

class SkillConnectDecorator < Draper::Decorator
	delegate_all
	attr_accessor :title, :modal_title,  :view_count, :model_name, :search_cond, :link, :mode, :modal_dlg_message

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
				I18n.t("cmn_sentence.listTitle", model:model.model_name.human)=>{controller:"office", action:"index"},
				I18n.t("cmn_sentence.newTitle", model:model.model_name.human)=>{controller:"office", action:"new"},
			}
		)

	end

	def nav_menu
		return "" if self.link.blank?
		h.content_tag(:ul, class:"nav nav-tabs") do
			self.link.each do |title, menu|
				h.concat( h.content_tag(:li, class:"nav-item mx-2") do
					h.concat ((title == self.title)? h.link_to(title, menu, class:"nav-link active") : h.link_to(title, menu, class:"nav-link text-white"))
				end)
			end
		end
	end

end

class ModalSCDecorator < Draper::Decorator
	delegate_all
	attr_accessor :title, :main_object
end
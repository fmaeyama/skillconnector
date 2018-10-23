module SkillHatContainer
	attr_reader :hat_decorator, :skill_decorator, :hats_hash

	def initialize
		@hat_decorator = HatDecorator.new
		#@skill_decorator = SkillDecorator.new
	end

	def build_hats_hash(model,id)
		@hats_hash=Hat.hats_hash(model,id,@hat_decorator)
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
class SkillConnectDecorator < Draper::Decorator
	delegate_all
	attr_accessor :title, :modal_title,  :view_count, :model_name, :search_cond, :link, :mode

	# @var.link = {
	#     I18n.t("cmn_sentence.listTitle", model:Office.model_name.human)=>{controller:"office", action:"index"},
	#     I18n.t("cmn_sentence.newTitle", model:Office.model_name.human)=>{controller:"office", action:"new"}
	# }
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
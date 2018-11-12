module GridHelper
  def helper_grid_link_to(model, action_name)
     content_tag  :div, class:"row" do
       content_tag :div, class:"col-auto" do
         content_tag(:span, class:"sl-title") do
           concat model.model_name.human
         end

         content_tag(:span, class:"sl-content") do
           concat link_to url_for(controller: 'grid', action: 'view', action_name:action_name), controller: 'grid', action: 'view', action_name:action_name
         end
       end
     end
  end
end

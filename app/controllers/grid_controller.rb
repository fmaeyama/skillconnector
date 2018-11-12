class GridController < ApplicationController
  def initialize
    super
    @var = GridDecorator.new
    @var.link = {
      I18n.t("cmn_sentence.listTitle", model: Engineer.model_name.human) => {controller: "engineer", action: "index"},
      I18n.t("cmn_sentence.newTitle", model: Engineer.model_name.human) => {controller: "engineer", action: "new"},
      I18n.t("cmn_sentence.listTitle", model: Office.model_name.human) => {controller: "office", action: "index"},
      I18n.t('cmn_sentence.listTitle', model: Business.model_name.human) => {controller: 'business', action: 'index'},
      I18n.t('cmn_sentence.listTitle', model: Offer.model_name.human) => {controller: 'offer', action: 'index'},
    I18n.t('cmn_sentence.listTitle', model: I18n.t("activerecord.models.grid")) => {controller: 'grid', action: 'index'}
    }
  end

  def index
    @var.title = I18n.t("cmn_sentence.listTitle", model: I18n.t("activerecord.models.grid"))
  end

  def view
    hat_types
#    eval 'self.'+params[:action_name]
  end

  def hat_levels
    @var.title = HatLevel.model_name.human
    @var.table_options = {
      editable: true,
      enableAddRow: true,
      autoEdit: false,
      enableCellNavigation: true,
      asyncEditorLoading: false,
      explicitInitialization: true,
      forceFitColumns: true,
      createPreHeaderPanel: true,
      showPreHeaderPanel: true,
      preHeaderPanelHeight: 23
    }
    @var.columns = [
      {field: "id", id: "id", name: "", minWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup:""},
      {field: "name", id: "name", name: "level name", minWidth: 60, editor: "Slick.Editors.Text", columnGroup:""},
      {field: "description", name: "description", minWidth: 100, editor: "Slick.Editors.Text", columnGroup:""},
      {field: "constraint", name: "id", minWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup:"constraint"},
      {field: "constraint_val", name: "value", minWidth: 20, cssClass: "row-hd", formatter: "Select2Formatter", editor:"Select2Editor", dataSource:"selList[0]", columnGroup:"constraint"},
      {field: "updated_at", name: "updated_at", minWidth: 20, cssClass: "row-hd"},
      {field: "created_at", name: "created_at", minWidth: 20, cssClass: "row-hd"}
    ]
    hl_temp = HatLevel.constraints.map {|k, v| [k, v]}.to_h
    @var.select_arr['constraint'] = HatLevel.constraints.map {|k, v| [v, I18n.t("level_constraint.#{k}")]}.to_h
    where_chain = HatLevel.all
    i = 0
    where_chain.find_each do |row|
      @var.data[i] = Hash.new
      @var.columns.each do |col|
        field = col[:field]
        case field
          when "constraint"
            @var.data[i][field] = hl_temp[row[field]]
            @var.data[i]["constraint_val"] = hl_temp[row[field]]
          else
            row.respond_to?(field) ? (@var.data[i][field] = row[field]) : (pp " ** field is #{field}")
        end
      end
      i = i.next
    end
    render layout: "grid_content"
  end

  def skill_levels
    general_grid SkillLevel
    @var.columns = [
      {field: "id", id: "id", name: "", minWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup:""},
      {field: "name", id: "name", name: "level name", minWidth: 60, editor: "Slick.Editors.Text", columnGroup:""},
      {field: "description", name: "description", minWidth: 100, editor: "Slick.Editors.Text", columnGroup:""},
      {field: "constraint", name: "id", minWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup:"constraint"},
      {field: "constraint_val", name: "value", minWidth: 20, cssClass: "row-hd", formatter: "Select2Formatter", editor:"Select2Editor", dataSource:"selList[0]", columnGroup:"constraint"},
      {field: "updated_at", name: "updated_at", minWidth: 20, cssClass: "row-hd"},
      {field: "created_at", name: "created_at", minWidth: 20, cssClass: "row-hd"}
    ]
    hl_temp = SkillLevel.constraints.map {|k, v| [k, v]}.to_h
    @var.select_arr['constraint'] = SkillLevel.constraints.map {|k, v| [v, I18n.t("level_constraint.#{k}")]}.to_h
    where_chain = SkillLevel.all
    i = 0
    where_chain.find_each do |row|
      @var.data[i] = Hash.new
      @var.columns.each do |col|
        field = col[:field]
        case field
          when "constraint"
            @var.data[i][field] = hl_temp[row[field]]
            @var.data[i]["constraint_val"] = hl_temp[row[field]]
          else
            row.respond_to?(field) ? (@var.data[i][field] = row[field]) : (pp " ** field is #{field}")
        end
      end
      i = i.next
    end
    render layout: "grid_content"
  end

  def hat_types
    general_grid HatType
    @var.columns = [
      {field: "id", id: "id", name: "#", maxWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: ""},
      {field: "name", id: "name", name: "level name", minWidth: 60, editor: "Slick.Editors.Text", columnGroup: ""},
      {field: "description", name: "description", minWidth: 100, editor: "Slick.Editors.Text", columnGroup: ""},
      {field: "status", name: "id", maxWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: "利用状況"},
      {field: "status_val", name: "status_val", minWidth: 20, cssClass: "row-hd",columnGroup: "利用状況",
        formatter:"Select2Formatter",editor: "Select2Editor", dataSource:"selList['status']"},
      {field: "hat_level_id", name: "id", maxWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: HatLevel.model_name.human},
      {field: "hat_level", name: HatLevel.model_name.human, minWidth: 20, cssClass: "row-hd", columnGroup: HatLevel.model_name.human,
        formatter:"Select2Formatter",editor: "Select2Editor", dataSource:"selList['hat_level_id']"},
      {field: "parent_hat_id", name: "id", maxWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: "type group"},
      {field: "parent_hat", name: "parent_hat", minWidth: 20, cssClass: "row-hd", columnGroup: "type group",
        formatter:"Select2Formatter",editor: "Select2Editor", dataSource:"selList['parent_hat_id']"},
      {field: "deleted_at", name: "削除日", minWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: ""},
      {field: "created_at", name: "作成日", minWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: ""}
    ]
    select_field = {"hat_level_id"=>"hat_level", "parent_hat_id"=>"parent_hat", "status" =>"status_val"}
    enum_field = {"status" =>HatType.statuses}
    @var.select_arr['hat_level_id'] = HatLevel.all.map {|hl| [hl.id,hl.name]}.to_h
    @var.select_arr['parent_hat_id'] = HatType.all.map{|ht| [ht.id, ht.name]}.to_h
    @var.select_arr['status'] = HatType.statuses.map{|key,val| [val,key]}.to_h
    where_chain = HatType.all
    check_and_set_select_field where_chain,select_field, enum_field
    render layout: "grid_content"
  end

  def skill_types
  end

  def trained_type

  end

  private
    def general_grid(model)
      @var.title = model.model_name.human
      @var.table_options = {
        editable: true,
        enableAddRow: true,
        autoEdit: false,
        enableCellNavigation: true,
        asyncEditorLoading: false,
        explicitInitialization: true,
        forceFitColumns: true,
        createPreHeaderPanel: true,
        showPreHeaderPanel: true,
        preHeaderPanelHeight: 23
      }
    end

    def check_and_set_select_field(where_chain, select_field,enum_field=null)
      i=0
      where_chain.find_each do |row|
        @var.data[i] = Hash.new
        @var.columns.each do |col|
          field = col[:field]
          if select_field.key?(field)
            @var.data[i][field] = (enum_field.nil? || !enum_field.key?(field)) ? row[field] : enum_field[field][row[field]]
            @var.data[i][select_field[field]] = @var.data[i][field]
          elsif select_field.value?(field)
            # do nothing
          else
            row.respond_to?(field) ? (@var.data[i][field] = row[field]) : (pp " ** field is #{field}")
          end
        end
        i= i+1
      end
    end
end

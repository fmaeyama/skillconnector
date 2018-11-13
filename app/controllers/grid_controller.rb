class InnerGrid

  @decorator = nil
  attr_writer :select_field, :enum_field, :where_chain

  def initialize(decorator)
    @decorator = decorator
    @enum_field = nil
    @select_field = nil
  end

  def init(model_class)
    self.general_grid(model_class)
    self.define_selector
    @decorator.columns = self.grid_info
    self.check_and_set_select_field
  end

  def check_and_set_select_field
    i=0
    @where_chain.find_each do |row|
      @decorator.data[i] = Hash.new
      @decorator.columns.each do |col|
        field = col[:field]
        if !@select_field.nil? && @select_field.key?(field)
          @decorator.data[i][field] = (!@enum_field.nil? && @enum_field.key?(field)) ? @enum_field[field][row[field]] : row[field]
          @decorator.data[i][@select_field[field]] = @decorator.data[i][field]
        elsif !@select_field.nil? && @select_field.value?(field)
          # do nothing
        else
          row.respond_to?(field) ? (@decorator.data[i][field] = row[field]) : (pp " ** field is #{field}")
        end
      end
      i = i+1
    end
  end

protected

  def general_grid(model)
    @decorator.title = model.model_name.human
    @decorator.table_options = {
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

  def select_arr
    @decorator.select_arr
  end
  def notice= message
    @decorator.notice = message
  end

# see https://github.com/6pac/SlickGrid/blob/master/slick.editors.js
# "Slick": {  "Editors": {
#     "Text": TextEditor,
#     "Integer": IntegerEditor,
#     "Float": FloatEditor,
#     "Date": DateEditor,
#     "YesNoSelect": YesNoSelectEditor,
#     "Checkbox": CheckboxEditor,
#     "PercentComplete": PercentCompleteEditor,
#     "LongText": LongTextEditor} }
  def grid_info
    raise NotImplementedError, "method grid_info should be overwritten"
    # sample
    [
      {field: "id", id: "id", name: "#", maxWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: ""},
      {field: "name", id: "name", name: "level name", minWidth: 60, editor: "Slick.Editors.Text", columnGroup: ""},
      {field: "hat_level_id", name: "id", maxWidth: 20, cssClass: "row-hd", columnGroup: HatLevel.model_name.human},
      {field: "hat_level", name: HatLevel.model_name.human, minWidth: 20, cssClass: "row-hd", columnGroup: HatLevel.model_name.human,
        formatter:"Select2Formatter",editor: "Select2Editor", dataSource:"selList['hat_level_id']"},
      {field: "parent_hat_id", name: "id", maxWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: "type group"},
      {field: "parent_hat", name: "parent_hat", minWidth: 20, cssClass: "row-hd", columnGroup: "type group",
        formatter:"Select2Formatter",editor: "Select2Editor", dataSource:"selList['parent_hat_id']"},
      {field: "deleted_at", name: "削除日", minWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: ""},
      {field: "created_at", name: "作成日", minWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: ""}
    ]
  end

  def define_selector
    raise NotImplementedError, "method define_selector should be overwritten"
    # sample
    self.select_field = {"hat_level_id"=>"hat_level", "parent_hat_id"=>"parent_hat", "status" =>"status_val"}
    self.enum_field = {"status" =>HatType.statuses}
    @decorator.select_arr['hat_level_id'] = HatLevel.all.map {|hl| [hl.id,hl.name]}.to_h
    @decorator.select_arr['parent_hat_id'] = HatType.all.map{|ht| [ht.id, ht.name]}.to_h
    @decorator.select_arr['status'] = HatType.statuses.map{|key,val| [val,key]}.to_h
    self.where_chain = HatType.all
    self.notice = "補足説明を記載します"
  end

end

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
    #trained_type
    eval 'self.'+params[:action_name]
  end
  def business_statuses
    grid = BusinessStatus::Grid.new(@var)
    grid.init BusinessStatus
    render layout: "grid_content"
  end

  def engineer_status_types
    grid = EngineerStatusType::Grid.new(@var)
    grid.init EngineerStatusType
    render layout: "grid_content"
  end
  def office_statuses
    grid = OfficeStatus::Grid.new(@var)
    grid.init OfficeStatus
    render layout: "grid_content"
  end
  def office_types
    grid = OfficeType::Grid.new(@var)
    grid.init OfficeType
    render layout: "grid_content"
  end
  def proposals
    grid = Proposal::Grid.new(@var)
    grid.init Proposal
    render layout: "grid_content"
  end
  def offices
    grid = Office::Grid.new(@var)
    grid.init Office
    render layout: "grid_content"
  end
  def engineers
    grid = Engineer::Grid.new(@var)
    grid.init Engineer
    render layout: "grid_content"
  end
  def businesses
    grid = Business::Grid.new(@var)
    grid.init Business
    render layout: "grid_content"
  end
  def careers
    grid = Career::Grid.new(@var)
    grid.init Career
    render layout: "grid_content"
  end
  def engineer_hope_businesses
    grid = EngineerHopeBusiness::Grid.new(@var)
    grid.init EngineerHopeBusiness
    render layout: "grid_content"
  end
  def contacts
    grid = Contact::Grid.new(@var)
    grid.init Contact
    render layout: "grid_content"
  end
  def engineer_hirings
    grid = EngineerHiring::Grid.new(@var)
    grid.init EngineerHiring
    render layout: "grid_content"
  end
  def staffs
    grid = Staff::Grid.new(@var)
    grid.init Staff
    render layout: "grid_content"
  end
  def users
    grid = ::Grid.new(@var)
    grid.init
    render layout: "grid_content"
  end
  def hat_types
    grid = HatType::Grid.new(@var)
    grid.init HatType
    render layout: "grid_content"
  end

  def skill_types
    grid = SkillType::Grid.new(@var)
    grid.init SkillType
    render layout: "grid_content"
  end

  def trained_types
    grid = TrainedType::Grid.new(@var)
    grid.init TrainedType
    render layout: "grid_content"
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

end

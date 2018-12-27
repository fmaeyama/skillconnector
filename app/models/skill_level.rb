class SkillLevel < ApplicationRecord
  has_many :skill_types
  enum constraint: HatLevel.constraints
  enum evaluation_type: ApplicationRecord.cmn_evaluation_types

  def required?
    (self.constraint_before_type_cast & SkillLevel.constraints[:required]) == SkillLevel.constraints[:required]
  end

  def multi?
    (self.constraint_before_type_cast & SkillLevel.constraints[:only_one]) != SkillLevel.constraints[:only_one]
  end

  def with_trained?
    self.trained_type?
  end

  class Grid < InnerGrid
    def grid_info
      [
          {field: "id", id: "id", name: "", minWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup:""},
          {field: "name", id: "name", name: "level name", minWidth: 60, editor: "Slick.Editors.Text", columnGroup:""},
          {field: "description", name: "description", minWidth: 100, editor: "Slick.Editors.Text", columnGroup:""},
          {field: "constraint", name: "id", minWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Integer", columnGroup:"constraint"},
          {field: "constraint_val", name: "value", minWidth: 20, cssClass: "row-hd", formatter: "Select2Formatter", editor:"Select2Editor", dataSource:"selList[0]", columnGroup:"constraint"},
          {field: "evaluation_type", name: "id", minWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Integer", columnGroup:"evaluation_type"},
          {field: "evaluation_type_val", name: "value", minWidth: 20, cssClass: "row-hd", formatter: "Select2Formatter", editor:"Select2Editor", dataSource:"selList[0]", columnGroup:"evaluation_type"},
          {field: "updated_at", name: "updated_at", minWidth: 20, cssClass: "row-hd"},
          {field: "created_at", name: "created_at", minWidth: 20, cssClass: "row-hd"}
      ]
    end

    def define_selector
      self.select_field = {constraint:"constraint_val", evaluation_type:"evaluation_type_val"}
      self.enum_field = {}

      @decorator.select_arr['constraint'] = SkillLevel.constraints.map {|k, v| [v, I18n.t("level_constraint.#{k}")]}.to_h
      @decorator.select_arr['evaluation_type'] = SkillLevel.evaluation_types.map {|k, v| [v, I18n.t("level_constraint.#{k}")]}.to_h
      self.where_chain = SkillLevel.all
    end

  end

end

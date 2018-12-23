class HatLevel < ApplicationRecord
  has_many :hat_types
  enum constraint: {free: 0, only_one: 1, required: 2, required_only_one: 3}
  enum evaluation_type: ApplicationRecord.cmn_evaluation_types

  def required?
    (self.constraint_before_type_cast & HatLevel.constraints[:required]) == HatLevel.constraints[:required]
  end

  def multi?
    (self.constraint_before_type_cast & HatLevel.constraints[:only_one]) != HatLevel.constraints[:only_one]
  end

  ## InnerGrid is in grid_controller.rb
  class Grid < InnerGrid
    def grid_info
      [
        {field: "id", id: "id", name: "#", maxWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: ""},
        {field: "name", id: "name", name: "level name", minWidth: 60, editor: "Slick.Editors.Text", columnGroup: ""},
        {field: "description", name: "description", minWidth: 200, cssClass: "row-hd", columnGroup: ""},
        {field: "constraint", name: "id", maxWidth: 20, cssClass: "row-hd", columnGroup: "レベル制約"},
        {field: "constraint_val", name: "constraint", minWidth: 20, cssClass: "row-hd", columnGroup: "レベル制約",
          formatter:"Select2Formatter",editor: "Select2Editor", dataSource:"selList['constraint']"},
        {field: "evaluation_type", name: "id", maxWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.integer", columnGroup: "evaluation"},
        {field: "evaluation_type_val", name: "type", minWidth: 20, cssClass: "row-hd", columnGroup: "evaluation",
          formatter:"Select2Formatter",editor: "Select2Editor", dataSource:"selList['evaluation_type']"},
        {field: "updated_at", name: "変更日", minWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: ""},
        {field: "created_at", name: "作成日", minWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: ""}
      ]
    end

    def define_selector
      self.select_field = {constraint:"constraint_val", evaluation_type:"evaluation_type_val"}
      self.enum_field = {constraint:HatLevel.constraints, evaluation_type: HatLevel.evaluation_types}
      @decorator.select_arr['constraint'] = HatLevel.constraints.map{|key,val| [key,val]}.to_h
      @decorator.select_arr['evaluation_type']= HatLevel.evaluation_types.map{|key,val| [key,val]}.to_h
      self.where_chain = HatLevel.all
    end

  end

end

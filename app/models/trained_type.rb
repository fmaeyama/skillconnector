class TrainedType < ApplicationRecord
  has_many :skills
  enum status: ApplicationRecord.cmn_statuses

  scope :active, -> {where(status: :enabled).order("rate")}

  class Grid < InnerGrid

    def define_selector
      self.select_field = {"skill_level_id"=>"skill_level", "parent_skill_id"=>"parent_skill", "status" =>"status_val"}
      self.enum_field = {"status" =>SkillType.statuses}
      self.select_arr['skill_level_id'] = SkillLevel.all.map {|hl| [hl.id,hl.name]}.to_h
      self.select_arr['parent_skill_id'] = SkillType.all.map{|ht| [ht.id, ht.name]}.to_h
      self.select_arr['status'] = SkillType.statuses.map{|key,val| [val,key]}.to_h
      self.where_chain = SkillType.all
    end

    def grid_info
      [
        {field: "id", id: "id", name: "#", maxWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: ""},
        {field: "name", id: "name", name: "level name", minWidth: 60, editor: "Slick.Editors.Text", columnGroup: ""},
        {field: "description", name: "description", minWidth: 100, editor: "Slick.Editors.Text", columnGroup: ""},
        {field: "status", name: "id", maxWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: "利用状況"},
        {field: "status_val", name: "status_val", minWidth: 20, cssClass: "row-hd",columnGroup: "利用状況",
          formatter:"Select2Formatter",editor: "Select2Editor", dataSource:"selList['status']"},
        {field: "skill_level_id", name: "id", maxWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: HatLevel.model_name.human},
        {field: "skill_level", name: SkillLevel.model_name.human, minWidth: 20, cssClass: "row-hd", columnGroup: SkillLevel.model_name.human,
          formatter:"Select2Formatter",editor: "Select2Editor", dataSource:"selList['skill_level_id']"},
        {field: "parent_skill_id", name: "id", maxWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: "type group"},
        {field: "parent_skill", name: "parent_hat", minWidth: 20, cssClass: "row-hd", columnGroup: "type group",
          formatter:"Select2Formatter",editor: "Select2Editor", dataSource:"selList['parent_skill_id']"},
        {field: "deleted_at", name: "削除日", minWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: ""},
        {field: "updated_at", name: "更新日", minWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: ""},
        {field: "created_at", name: "作成日", minWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: ""}
      ]
    end

  end

end

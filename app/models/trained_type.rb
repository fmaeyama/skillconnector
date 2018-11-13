class TrainedType < ApplicationRecord
  has_many :skills
  enum status: ApplicationRecord.cmn_statuses

  scope :active, -> {where(status: :enabled).order("rate")}

  class Grid < InnerGrid

    def define_selector
      self.select_field = {"status" =>"status_val"}
      self.enum_field = {"status" =>TrainedType.statuses}
      self.select_arr['status'] = TrainedType.statuses.map{|key,val| [val,key]}.to_h
      self.where_chain = TrainedType.all
      self.notice = "※タイトルの日本語化は ja.yaml の編集が必要です"
    end

    def grid_info
      [
        {field: "id", id: "id", name: "#", maxWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: ""},
        {field: "name", id: "name", name: "タイトル", minWidth: 60, editor: "Slick.Editors.Text", columnGroup: ""},
        {field: "description", name: "習熟度説明", minWidth: 100, editor: "Slick.Editors.Text", columnGroup: ""},
        {field: "rate", name: "順位", maxWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Integer", columnGroup: ""},
        {field: "status", name: "id", maxWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Integer", columnGroup: "利用状況"},
        {field: "status_val", name: "status_val", minWidth: 20, cssClass: "row-hd",columnGroup: "利用状況",
          formatter:"Select2Formatter",editor: "Select2Editor", dataSource:"selList['status']"},
        {field: "updated_at", name: "更新日", minWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: ""},
        {field: "created_at", name: "作成日", minWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: ""}
      ]
    end

  end

end

class BusinessStatus < ApplicationRecord
  has_many :businesses
  scope :active, -> {order("sort_id")}
  scope :enable, -> {where("disable_from > ?", datetime).order("sort_id")}

  class Grid < InnerGrid
    def grid_info
      [
        {field: "id", id: "id", name: "#", maxWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: ""},
        {field: "name", id: "name", name: "タイトル", minWidth: 60, editor: "Slick.Editors.Text", columnGroup: ""},
        {field: "description", id: "description", name: "詳細", minWidth: 60, editor: "Slick.Editors.Text", columnGroup: ""},
        {field: "sort_id", name: "並び順", maxWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Interger",columnGroup: ""},
        {field: "group_id", name: "id", maxWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Interger",columnGroup: "表示制御グループ"},
        {field: "group_val", name: "value", minWidth: 20, cssClass: "row-hd",columnGroup: "表示制御グループ",
          formatter:"Select2Formatter",editor: "Select2Editor", dataSource:"selList['status']"},
        {field: "status", name: "id", maxWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Integer", columnGroup: "表示フラグ"},
        {field: "status_val", name: "value", minWidth: 20, cssClass: "row-hd",columnGroup: "表示フラグ",
          formatter:"Select2Formatter",editor: "Select2Editor", dataSource:"selList['status']"},
        {field: "disable_from", name: "廃止日", minWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: ""},
        {field: "updated_at", name: "更新日", minWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: ""},
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
    end

  end

end

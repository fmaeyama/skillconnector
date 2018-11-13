class EngineerHiring < ApplicationRecord
  belongs_to :office
  belongs_to :hiring_contact, class_name: "Contact", required: false
  belongs_to :engineer
  enum status: ApplicationRecord.cmn_statuses
  after_initialize :set_default_value, if: :new_record?

  scope :active, -> {where('status=1')}
  class Grid < InnerGrid
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
    end

  end

  private

    def set_default_value
      self.status = 1
    end
end

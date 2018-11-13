class Office < ApplicationRecord
  belongs_to :parent, class_name: "Office", foreign_key: "parent_id", optional: true
  has_many :children, class_name: "Office", foreign_key: "parent_id"
  belongs_to :office_type
  belongs_to :primary_address, class_name: 'Address', optional: true
  belongs_to :primary_contact, class_name: 'Contact', optional: true
  belongs_to :office_status
  has_and_belongs_to_many :contacts
  has_many :businesses
  has_one :engineer_hiring

  accepts_nested_attributes_for :primary_address
  accepts_nested_attributes_for :primary_contact

  def location_short
    self.primary_address.location_short

  end

  def get_long_name
    "#{self.cd}:#{self.name}(#{self.location_short})"
  end
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

end

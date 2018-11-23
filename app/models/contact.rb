class Contact < ApplicationRecord
  has_and_belongs_to_many :offices
  has_many :office_primaries, class_name: 'Office', foreign_key: 'primary_contact_id'
  enum contact_type: {email: 0, tel: 1, fax: 2}

  scope :office_contact, -> (office_id) do
    Contact.left_joins(:offices).left_joins(:office_primaries).where("offices.id = ? or office_primaries_contacts.id=?", office_id, office_id)
  end

  def display_name
    "#{self.contact_name} (#{self.title})"
  end

  def self.permitParams(params, key)
    params.require(key).permit(
      :contact_name, :contact_kana, :title,
      :contact_type, :contact_value
    )
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

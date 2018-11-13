class Proposal < ApplicationRecord
  belongs_to :offer
  belongs_to :engineer
  belongs_to :offered_staff, class_name: 'Staff'
  belongs_to :office_contact, class_name: 'Contact', required: false
  scope :related_office, -> {joins(:offer).joins(:business).joins(:office)}

  def other_engineers
    Engineer.select("engineers.*", "proposals.id as proposalid").joins(:proposals).where("proposals.offer_id=?", self.offer_id).where.not({proposals: {id: self.id}})
  end

  def other_offers
    Offer.select("offers.*", "proposals.id as proposalid").joins(:proposals).where({proposals: {engineer_id: self.engineer_id}}).where.not({proposals: {id: self.id}})
  end


  def get_related_office_id
    office = Office.joins(businesses: [offers: [:proposals]]).where("proposals.id=?", self.id)
    return -1 if office.size == 0
    office.first!.id
  end

  def description
    res = ""
    res += self.engineer.person_info.getFullName unless self.engineer.person_info.blank?
    res += " "
    res += self.offer.title unless self.offer.blank?
    return res
  end

  def self.parameters(params, key)
    params.require(key).permit(
      :offer_id, :engineer_id, :offered_staff_id, :office_contact_id,
      :history
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

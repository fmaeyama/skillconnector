class Engineer < ApplicationRecord
  belongs_to :engineer_registration_type
  belongs_to :engineer_status_type
  has_one :engineer_hiring, autosave: true
  has_one :office, through: :engineer_hiring
  belongs_to :person_info, autosave: true
  has_many :careers
  has_many :engineer_hope_businesses
  has_many :proposals
  accepts_nested_attributes_for :engineer_hiring, :person_info, update_only: true
  accepts_nested_attributes_for :careers, allow_destroy: true,
    reject_if: proc {|attr| attr['skill_id'].blank?}
  accepts_nested_attributes_for :engineer_hope_businesses, allow_destroy: true, reject_if: :all_blank
  after_initialize :set_default_value, if: :new_record?


  def self.parameters(param_hash, key)
    param_hash.require(key).permit(
      :eng_cd, :engineer_registration_type_id,
      :registration_memo, :engineer_status_type_id,
      :person_info_attributes => [
        :last_name, :first_name, :middle_name,
        :kana_last_name, :kana_first_name, :kana_middle_name
      ],
      :engineer_hiring_attributes => [
        :office_id, :hiring_position, :hiring_division,
        :hiring_memo, :hiring_contact_id,
        :hired_from, :hired_until, :status
      ],
      :careers_attributes => [
        :id, :skill_id, :career_from, :career_at, :description, :_destroy
      ],
      :engineer_hope_businesses_attributes => [
        :id, :_destroy, :business_type_id, :skill_id, :hope_since, :hope_strength,
        :description
      ]
    )
  end

  def get_engineer_hiring
    return I18n.t("cmn_dict.personalContract") if self.engineer_hiring.nil?
    I18n.t("cmn_dict.corporateContract") + self.engineer_hiring.office.get_long_name
  end

  def get_career_summary
    result = []
    self.careers.each do |career|
      result << career.name
    end
    result.join(",")
  end

  def get_hope_business_summary
    result = []
    self.engineer_hope_businesses do |hope|
      result << hope.name
    end
    result.join(",")
  end

  def get_status
    return I18n.t("cmn_dict.not_defined") if self.engineer_status_type.blank?
    self.engineer_status_type.name
  end

  def associate_hat_skill(hat_decorator)

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

  private

    def set_default_value
      self.build_engineer_hiring(office: Office.first)
      self.build_person_info
      self.engineer_registration_type_id = EngineerRegistrationType.select(:id).first
      self.engineer_status_type_id = EngineerStatusType.select(:id).first
      self.careers.build
      self.engineer_hope_businesses.build
    end
end

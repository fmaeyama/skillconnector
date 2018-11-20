class Business < ApplicationRecord

  has_one :parent, class_name: "Business", foreign_key: "parent_business_id"
  has_many :children, class_name: "Business", foreign_key: "parent_business_id"
  has_many :offers
  belongs_to :business_type
  belongs_to :business_status
  belongs_to :office

  has_many :hats, as: :hat_reference
  has_many :skills, as: :skill_reference
  has_one :hat_supplement, as: :hat_supplemental
  has_one :skill_supplement, as: :skill_supplemental
  accepts_nested_attributes_for :offers

  enum scheduled_project_span_type: {day:0, month:1, year:2, open:3}

  def self.span_type_hashes
    self.scheduled_project_span_types.map {|k,v| [I18n.t("scheduled_project_span_type.#{k}"),v]}
  end

  def self.business_params(param_hash, key)
    param_hash.require(key).permit(
      :id, :name, :description, :welcome, :office_id,
      :business_type_id, :business_status_id, :parent_business_id,
      :max_quantity, :proper_quantity, :budget, :open_date,
      :enable_date, :end_date, :expire_schedule, :project_participation_type_id,
      :scheduled_project_start, :scheduled_project_end
    )
  end

  def init_new_instance(params)
    self.business_status_id = BusinessStatus.select(:id).first(1)
    self.business_type_id = BusinessType.select(:id).first(1)
    self.offers.build
    self.id = -1
    if params.key?("office_id")
      self.office_id = params["office_id"]
    end

  end

  def get_parent_business_name
    return if self.parent_id == 0
    self.parent.name
  end

  def has_default_offer?
    (self.offers.size > 0) && self.offers[0].persisted?
  end

  def default_offer
    self.has_default_offer? ? self.offers[0] : nil
  end

  class Grid < InnerGrid
    def grid_info
      raise NotImplementedError, "method grid_info should be overwritten"
      # sample
      [
        {field: "id", id: "id", name: "#", maxWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: ""},
        {field: "name", id: "name", name: "タイトル", minWidth: 60, editor: "Slick.Editors.Text", columnGroup: ""},
        {field: "description", id:"description",name: "習熟度説明", minWidth: 100, editor: "Slick.Editors.Text", columnGroup: ""},
        {field: "rate", id:"rate",name: "順位", maxWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Integer", columnGroup: ""},
        {field: "status", id:"status",name: "id", maxWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Integer", columnGroup: "表示フラグ"},
        {field: "status_val", id:"status_val", name: "value", minWidth: 20, cssClass: "row-hd",columnGroup: "表示フラグ",
          formatter:"Select2Formatter",editor: "Select2Editor", dataSource:"selList['status']"},
        {field: "updated_at", id:"updated_at", name: "更新日", minWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: ""},
        {field: "created_at", id:"created_at",name: "作成日", minWidth: 20, cssClass: "row-hd", editor: "Slick.Editors.Checkbox", columnGroup: ""}
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

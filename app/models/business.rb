class Business < ApplicationRecord

  has_one :parent, class_name: "Business", foreign_key: "parent_business_id"
  has_many :children, class_name: "Business", foreign_key: "parent_business_id"
  has_many :offers
  has_many :hats, as: :hat_reference
  has_many :skills, as: :skill_reference
  has_one :hat_supplement, as: :hat_supplemental
  has_one :skill_supplement, as: :skill_supplemental
  belongs_to :business_type
  belongs_to :business_status
  belongs_to :office

  def self.business_params(param_hash, key)
    param_hash.require(key).permit(
      :id, :name, :description, :welcome, :office_id,
      :business_type_id, :business_status_id, :parent_business_id,
      :max_quantity, :proper_quantity, :budget, :open_date,
      :enable_date, :end_date, :expire_schedule
    )
  end

  def init_new_instance(params)
    self.business_status_id = BusinessStatus.select(:id).first(1)
    self.business_type_id = BusinessType.select(:id).first(1)
    if params.key?("office_id")
      self.office_id = params["office_id"]
    end

  end

  def get_parent_business_name
    return if self.parent_id == 0
    self.parent.name
  end

  class Grid < InnerGrid

  end

end

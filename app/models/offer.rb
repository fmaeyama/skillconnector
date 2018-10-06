class Offer < ApplicationRecord
  belongs_to :business
  belongs_to :offer_status
  has_many :proposals

	def self.parameters(param_hash,key)
		param_hash.require(key).permit(
			:business_id, :title, :description, :offer_status_id,
			:start_from, :want_until, :work_at
		)
	end

	def brothers
		Offer.where(business_id: self.business_id).where.not(id: self.id)
	end
end

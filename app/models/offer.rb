class Offer < ApplicationRecord
  belongs_to :business
  belongs_to :offer_status

	def self.parameters(param_hash,key)
		param_hash.require(key).permit(
			:business_id, :title, :description, :offer_status_id,
			:start_from, :want_until, :work_at
		)
	end
end

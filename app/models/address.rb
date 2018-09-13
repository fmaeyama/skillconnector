class Address < ApplicationRecord
	belongs_to :prefecture
	has_many :offices

	def self.addressParams(paramHash, key)
		paramHash.require(key).permit(
			:id, :postal_code, :prefecture_id, :address, :building, :about_this
		)
	end

	def postal_code_for_print
		return "" if self.postal_code.blank?
		return self.postal_code if self.postal_code.length < 4
		"〒"+self.postal_code[1,3] +
			"-"+ self.postal_code[4,self.postal_code.length]
	end

	def location_long
		self.postal_code_for_print + self.prefecture.name + self.address + self.building
	end

	def location_short
		self.prefecture.name + self.address
	end

end

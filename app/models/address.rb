class Address < ApplicationRecord
  belongs_to :prefecture
  has_many :offices

  def self.addressParams(paramHash,key)
    paramHash.require(key).permit(
        :id,:postal_code,:prefecture_id,:address,:building,:about_this
    )
  end
end

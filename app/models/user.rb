class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable
	has_many :user_privilege_groups
	has_many :privilege_groups, through: :user_privilege_groups
	belongs_to :person_info, required: false

	attr_accessor :privilage_level
	def getUserImages

		imageHash = {}
		imageHash["main"] = "icons/noImage.jpg"
		imageHash[:sub_image] = "icons/sample-image.jpg"
		return imageHash

	end


end

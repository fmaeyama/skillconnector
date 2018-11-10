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

	def get_display_image
		# 写真が登録されている場合はそれを表示する
		# ない場合は、管理者/求人担当/技術者/派遣担当で識別されたアイコンを表示する
		privs = self.get_user_privs_arr
		return "icons/Admin1.png" if privs.include?(1)
		return "icons/biz1.png" if privs.include?(2)
		return "icons/Usr1.png" if privs.include?(3)
		"icons/notassign1.png"
	end

	def get_user_privs_arr
		res = []

		self.privilege_groups.each do |privGroup|
			res.append(privGroup.id)
		end

		res
	end


end

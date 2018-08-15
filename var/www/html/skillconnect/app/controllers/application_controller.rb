module CondEnum
	LIKE = 'like'.freeze
	EQ = 'eq'.freeze
	FROM = 'from'.freeze
	TO = 'to'.freeze
	IN = 'in'.freeze
end

class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	before_action :setAuthentication

	# 定数は大文字アルファベットから始める
	PRIV_SYSADMIN = 4 # 管理スタッフユーザー
	PRIV_BIZADMIN = 2 # 企業側スタッフユーザー
	PRIV_USER = 1 # サイトユーザー

	# 変数は小文字またはアンダーバーでアクセス
	@privilegeLevel = 0
	
	attr_accessor :class_permission
	
	
	def setAuthentication
		if user_signed_in? then
			@user = current_user
		else
			return
			# @userに何か値を入れる
		end
		
		
		if 	current_user.privilege_groups.count > 0 then
			current_user.privilege_groups.each do |privGroup|
				case privGroup.id
					when 1 #
						@privilegeLevel += PRIV_SYSADMIN
					when 2
						@privilegeLevel += PRIV_BIZADMIN
					when 2
						@privilegeLevel += PRIV_USER
				end
				privGroup.control_privileges do |control|
					@class_permission[control.controller_name] = control.privilege_type
				end
			end
		end
		
	end

	#TODO コントロール名により実行可否を返す関数
	def checkPermission(controll, action)
		@class_permission[controll]
	end

	def createCondition(params, whereList)
		cond = []
		foreach params do |col, val|
			case whereList(col)
				when CondEnum::LIKE
					break
				when CondEnum::EQ
					break
				when CondEnum::IN
					break
				when CondEnum::FROM
					break
				when CondEnum::TO
					break
			end
		end
		return cond
	end
	
	
	
	end

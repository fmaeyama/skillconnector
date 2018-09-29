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

	rescue_from 'ActionView::Template::Error' do |exception|
		render xml: exception, status: 500
	end

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

	def createCondition(params, whereList, freeword)
		cond = ["1=1"]
		condArr = []
		find_cond = {}
		params.each do |col, val|
			unless val.blank?
				next unless whereList.key?(col.to_sym)
				find_cond[col.to_sym]=val
				case whereList[col.to_sym]
					when CondEnum::LIKE
						cond << col.to_s + ' like ?'
						condArr << '%'+val+'%'
					when CondEnum::EQ
						cond << col.to_s + ' = ?'
						condArr << val
					when CondEnum::IN
						cond << col.to_s + ' in (' + val.join(",") + ")"
					when CondEnum::FROM
						cond << col.to_s + ' > ?'
						condArr << val
					when CondEnum::TO
						cond >> col.to_s + ' < ?'
						condArr << val
					else
						next # 何もしない
				end
			end
		end

		freekey = freeword.keys[0].to_s
		unless (params[freekey].blank?)
			find_cond[freekey.to_sym] =params[freekey]
			tmp_str = getFreewordSearchStringFromArray(freeword.values[0], params[freekey])
			cond << "(" + tmp_str + ")"
		end
		if condArr.count > 0
			cond = [cond.join(' and '),condArr]
		else
			cond = [cond.join(' and ')]
		end

		condStr = cond.flatten
		{cond_arr: condStr, cond_param: find_cond}
	end
	
	private

	def getFreewordSearchStringFromArray(arr,word)
		return '1=1' if arr.count == 0
		res = arr.join(" LIKE '%%" + word + "%%' or ")
		res +=  " LIKE '%%" + word + "%%'"
	end
	
	end

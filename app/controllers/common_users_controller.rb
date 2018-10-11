class CommonUsersController < ApplicationController


	def initialize
		super
		@var = CommonUserDecorator.new
		@var.link={
			I18n.t("cmn_sentence.listTitle", model:Offer.model_name.human)=>{controller:"offer", action:"index"},
			I18n.t('cmn_sentence.listTitle',model: Office.model_name.human) => {controller:'office', action:'index'},
			I18n.t('cmn_sentence.listTitle', model: Business.model_name.human) => {controller:'business', action: 'index'}		}
	end
	def index
		#   userの一覧を表示
		@allusers = get_list()

	end

	# 現在ログイン中の企業に紐付いたユーザーの一覧のみを表示
	def biz_index
		@allusers = get_list(current_user.bizArray)
	end

	# 現在ログイン中の企業にログインユーザーを作成
	def biz_useradd

	end


	def edit
		#TODO POSTされた値により個人の属性を追加・編集する
		# @person_info = PersonInfo.new
	end

	# 新規登録者情報を作成する。必ずしもログインとは紐付かない
	def new
		@newPersonInfo = PersonInfo.new
		@newPersonInfo.first_name = 'Neest'
	end

	# addはnewと異なり、ログインユーザーを追加する
	def add
		render :text => "render test"
		#TODO パスワードを発行して、ユーザーの追加を行う
	end

	def details
	end

	# ユーザー権限割当
	# ユーザーと権限(privilege_group.title)の一覧表
	# ユーザー毎の権限設定も可能
	def assign_role
		# 1.ユーザーと権限の一覧を作成: user.id, name, 権限セットのチェックボックス
		@var.title = t('.title')
		@user_privs = User.select('users.*','user_privilege_groups.privilege_group_id').left_joins(:user_privilege_groups)
	end

	def priv_update
		user_id = params[:user_priv][:user_id]
		priv_id = params[:user_priv][:priv_id]
		UserPrivilegeGroup.transaction do
			if priv_id.blank?
				UserPrivilegeGroup.delete(UserPrivilegeGroup.find_by(user_id:user_id))
				@user_priv=UserPrivilegeGroup.new(user_id:user_id)
			else
				@user_priv = UserPrivilegeGroup.find_or_create_by(user_id: user_id)
				@user_priv.privilege_group_id = priv_id
				@user_priv.save!
			end

		end
	end

	private

		def get_list(arrBizid = nil)
			allusers = User.all.includes(:person_info)
			return allusers

		end


end

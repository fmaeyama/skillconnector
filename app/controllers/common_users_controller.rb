class CommonUsersController < ApplicationController

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

	end

	private
	def get_list(arrBizid=nil)
		allusers = User.all.includes(:person_info)
		return allusers

	end


end

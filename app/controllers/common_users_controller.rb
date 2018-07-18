class CommonUsersController < ApplicationController

  def index
  #   userの一覧を表示
    @allusers = User.all.includes(:person_info)
	  
  end
		
	def edit
		#TODO POSTされた値により個人の属性を追加・編集する
		# @person_info = PersonInfo.new
	end

  def new
	  @newPersonInfo = PersonInfo.new
	  @newPersonInfo.first_name = 'Neest'
  end
  
  #
  #
  def add
    render :text => "render test"
	  #TODO パスワードを発行して、ユーザーの追加を行う
  end

  def details
  end

end

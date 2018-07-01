class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    # TODO: 今日のお知らせを表示（期限を切って表示させる）
    # TODO: 権限に応じて、sysadmin, bizadminのメニューを表示（Expanded)
    @visibleSysadmin = true;
    @visiblebizadmin = true;
  end

  def sysadmin
    # システム管理者メニュー
    # TODO: ユーザー認証により表示させるか、404を表示する

  end

  def bizadmin
    # 企業管理者メニュー
    link = [
        { title:"ユーザー管理", contoller:"user" , action:"getList"},
        { title:"", contoller:"" , action:""}
    ]
  end


  private
  def getSysadminMenu()
    link = [
        { title:"ユーザー管理", contoller:"user" , action:"getList"},
        { title:"", contoller:"" , action:""}
    ]

  end

end

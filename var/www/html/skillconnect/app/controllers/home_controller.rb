class HomeController < ApplicationController

  
  def index
    # TODO: 今日のお知らせを表示（期限を切って表示させる）
    # TODO: 権限に応じて、sysadmin, bizadminのメニューを表示（Expanded)
    @visibleSysadmin = true;
    @visiblebizadmin = true;
    @page_title = "SILVERION menu"
    @title = '総合メニュー'
  end

  def sysadmin
    # システム管理者メニュー
    # TODO: ユーザー認証により表示させるか、404を表示する
    @visibleSysadmin = true;
    @visiblebizadmin = true;
    @currentIndex = 'sysadmin'
    @page_title = "SILVERION menu"
    @title = 'システム管理者メニュー'

    render action: 'index'

  end

  def bizadmin
    # 企業管理者メニュー
    link = [
        { title:"ユーザー管理", contoller:"user" , action:"getList"},
        { title:"", contoller:"" , action:""}
    ]
    @visibleSysadmin = true;
    @visiblebizadmin = true;
    @currentIndex = 'bizadmin'
    @page_title = "SILVERION menu"
    @title = '求人管理者メニュー'

    render action: 'index'
  end

  def useradmin
    @visibleSysadmin = true;
    @visiblebizadmin = true;
    @currentIndex = 'useradmin'
    @page_title = "SILVERION menu"
    @title = '技術者メニュー'

    render action: 'index'
  end

  private
  def getSysadminMenu()
    link = [
        { title:"ユーザー管理", contoller:"user" , action:"getList"},
        { title:"", contoller:"" , action:""}
    ]

  end

end

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
    @link = {
        'ユーザー管理' => [
            { title:"ログインユーザー一覧", controller:"common_users" , action:"index"},
            { title:"ログインユーザー新規作成", controller:"common_users" , action:"add"},
            { title:"登録者情報作成・編集", controller:"common_users", action:"index"}],
        '権限管理'=>[
            {title: 'ユーザー権限割当', controller: 'common_users', action: 'assign_role'},
            {title: '権限設定画面', controller: 'privilege', action: 'assign_role'}],
        t(:cmn_dict.business)+'管理'=>[
            {title: t(:cmn_dict.business)+'一覧',controller:"businesses", action:"index"},
            [title: t(:cmn_dict.business)+'新規作成',controller:"businesses", action:"new"]],
        t(:cmn_dict.property)+'管理'=>[
            {title: t(:cmn_dict.property)+'一覧', controller:"properties", action:"index"},
            {title: t(:cmn_dict.property)+'新規作成', controller:"properties", action:"new"}
        ],
        t(:cmn_dict.project)+'管理'=>[
            {title: t(:cmn_dict.project)+'一覧', controller: 'projects', action: "index" },
            {title: t(:cmn_dict.project)+'新規作成', controller: 'projects', action: "index" }]
    }
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
    @link = {
        'ユーザー管理' => [
            { title:"ログインユーザー一覧", controller:"common_users" , action:"biz_index"},
            { title:"ログインユーザー新規作成", controller:"common_users" , action:"biz_useradd"},
            { title:"登録者情報作成・編集", controller:"common_users", action:"biz_index"}],
        t(:cmn_dict.business)+'管理'=>[
            {title: t(:cmn_dict.business)+'編集',controller:"businesses", action:"edit_own"},
            {title: t(:cmn_dict.business)+'連絡先一覧・編集',controller:"businesses", action:"contact_list"}
        ],
        t(:cmn_dict.project)+'管理'=>[
            {title: t(:cmn_dict.project)+'一覧', controller: 'projects', action: "index" },
            {title: t(:cmn_dict.project)+'詳細', controller: 'projects', action: "detail" },
            {title: t(:cmn_dict.project)+'新規作成', controller: 'projects', action: "index" }]

    }

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
    @link = {'ユーザー管理' => [
        { title:"基本情報・プロフィール編集", controller:"common_users" , action:"edit_own_info"},
        { title:"スキル編集・登録", controller:"common_users" , action:"edit_skills"},
        { title:"パスワード変更", controller:"common_users", action:"new"}]
    }

    render action: 'index'
  end

  private
  def getSysadminMenu()
    @link = {'ユーザー管理' => [
        { title:"ログインユーザー一覧", contoller:"common_users" , action:"index"},
        { title:"ログインユーザー新規作成", contoller:"common_users" , action:"add"},
        { title:"登録者情報作成・編集", controller:"common_users", action:"new"}]
    }

  end

end

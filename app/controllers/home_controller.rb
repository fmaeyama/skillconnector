class HomeController < ApplicationController

  def sysadmin
    # システム管理者メニュー
    @link = {
        'ユーザー管理' => [
            {title: 'ログインユーザー一覧', controller: 'common_users', action: 'index'},
            #{title: 'ログインユーザー新規作成', controller: 'common_users', action: 'add'},
            #{title: "登録者情報作成・編集", controller: "common_users", action: "index"},
            {title: 'ユーザー権限割当', controller: 'common_users', action: 'assign_role'},
            {title: '権限設定画面', controller: 'privilege', action: 'assign_role'}],
        t("cmn_sentence.menuParents", model:Staff.model_name.human) => [
            {title: t("cmn_sentence.listTitle", model: Staff.model_name.human) , controller: "staff", action: "index"},
            {title: t("cmn_sentence.newTitle", model: Staff.model_name.human) , controller: "staff", action: "new"}],
        t(:office, scope: [:cmn_dict]) + '管理' => [
            {title: t(:office, scope: [:cmn_dict]) + '一覧', controller: "office", action: "index"},
            {title: t(:office, scope: [:cmn_dict]) + '新規作成', controller: "office", action: "new"}],
        t(:business, scope: [:cmn_dict]) + '管理' => [
            {title: t(:business, scope: [:cmn_dict]) + '一覧', controller: "business", action: "index"},
            {title: t(:business, scope: [:cmn_dict]) + '新規作成', controller: "business", action: "new"}],
        t("cmn_sentence.menuParents", model: Engineer.model_name.human) => [
            {title: t("cmn_sentence.listTitle", model: Engineer.model_name.human) , controller: "engineer", action: "index"},
            {title: t("cmn_sentence.newTitle", model: Engineer.model_name.human) , controller: "engineer", action: "new"}],
        t("cmn_sentence.menuParents", model:Offer.model_name.human) => [
            {title: t("cmn_sentence.listTitle", model: Offer.model_name.human) , controller: "offer", action: "index"},
            {title: t("cmn_sentence.newTitle", model: Offer.model_name.human) , controller: "offer", action: "new"}],
        t("cmn_sentence.menuParents", model:Proposal.model_name.human) => [
            {title: t("cmn_sentence.listTitle", model: Proposal.model_name.human) , controller: "proposal", action: "index"},
            {title: t("cmn_sentence.newTitle", model: Proposal.model_name.human) , controller: "proposal", action: "new"}]
    }
    # TODO: ユーザー認証により表示させるか、404を表示する
    @currentIndex = 'sysadmin'
    @page_title = "SILVERION menu"
    @title = 'システム管理者メニュー'

    render action: 'index'

  end

  def bizadmin
    # 企業管理者メニュー
    @link = {
        t(:business, scope: [:cmn_dict]) + '管理' => [
            {title: t(:business, scope: [:cmn_dict]) + '一覧', controller: "business", action: "index"},
            {title: t(:business, scope: [:cmn_dict]) + '新規作成', controller: "business", action: "new"}],
        t("cmn_sentence.menuParents", model: Engineer.model_name.human) => [
            {title: t("cmn_sentence.listTitle", model: Engineer.model_name.human) , controller: "engineer", action: "index"},
            {title: t("cmn_sentence.newTitle", model: Engineer.model_name.human) , controller: "engineer", action: "new"}],
        t("cmn_sentence.menuParents", model:Offer.model_name.human) => [
            {title: t("cmn_sentence.listTitle", model: Offer.model_name.human) , controller: "offer", action: "index"},
            {title: t("cmn_sentence.newTitle", model: Offer.model_name.human) , controller: "offer", action: "new"}]
    }

    @currentIndex = 'bizadmin'
    @page_title = "SILVERION menu"
    @title = '求人管理者メニュー'

    render action: 'index'
  end

  def user
    @currentIndex = 'useradmin'
    @page_title = "SILVERION menu"
    @title = '技術者メニュー'
    @link = {'ユーザー管理' => [
        {title: 'ログインユーザー一覧', controller: 'common_users', action: 'index'},
        {title: 'ログインユーザー新規作成', controller: 'common_users', action: 'add'},
        {title: "登録者情報作成・編集", controller: "common_users", action: "index"}]
    }

    render action: 'index'
  end

  def index
    # TODO: 今日のお知らせを表示（期限を切って表示させる）
    # TODO: 権限に応じて、sysadmin, bizadminのメニューを表示（Expanded)
    set_privilage
    visible_sysadmin = true if current_user.privilage_level >= PRIV_SYSADMIN
    visible_bizadmin = true if current_user.privilage_level >= PRIV_BIZADMIN
    @page_title = "SILVERION menu"
    @title = '総合メニュー'
    if visible_sysadmin then
      sysadmin and return
    end

    if visible_bizadmin then
      sysadmin and return
    end

    user

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

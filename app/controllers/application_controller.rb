require 'pp'

module CondEnum
  LIKE = 'like'.freeze
  EQ = 'eq'.freeze
  FROM = 'from'.freeze
  TO = 'to'.freeze
  IN = 'in'.freeze
end

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_authentication, unless: :redirect_condition

  # 定数は大文字アルファベットから始める
  PRIV_SYSADMIN = 4 # 管理スタッフユーザー
  PRIV_BIZADMIN = 2 # 企業側スタッフユーザー
  PRIV_USER = 1 # サイトユーザー

  # 変数は小文字またはアンダーバーでアクセス
  @privilegeLevel = 0

  attr_accessor :class_permission

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
        find_cond[col.to_sym] = val
        case whereList[col.to_sym]
        when CondEnum::LIKE
          cond << col.to_s + ' like ?'
          condArr << '%' + val + '%'
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

    unless (freeword.nil?)
      freekey = freeword.keys[0].to_s
      find_cond[freekey.to_sym] = params[freekey]
      tmp_str = getFreewordSearchStringFromArray(freeword.values[0], params[freekey])
      cond << "(" + tmp_str + ")"
    end
    if condArr.count > 0
      cond = [cond.join(' and '), condArr]
    else
      cond = [cond.join(' and ')]
    end

    condStr = cond.flatten
    {cond_arr: condStr, cond_param: find_cond}
  end

  def set_privilage
    current_user.privilage_level = 0
    if current_user.privilege_groups.count > 0 then
      current_user.privilege_groups.each do |privGroup|
        case privGroup.id
        when 1 #
          current_user.privilage_level += PRIV_SYSADMIN
        when 2
          current_user.privilage_level += PRIV_BIZADMIN
        when 3
          current_user.privilage_level += PRIV_USER
        end
        privGroup.control_privileges do |control|
          @class_permission[control.controller_name] = control.privilege_type
        end
      end
    end
    current_user.privilage_level
  end

  private

  def getFreewordSearchStringFromArray(arr, word)
    return '1=1' if arr.count == 0
    res = arr.join(" LIKE '%%" + word + "%%' or ")
    res += " LIKE '%%" + word + "%%'"
  end

  def set_authentication
    if user_signed_in? then
      @user = current_user
    else
      @user = nil
      return
      # @userに何か値を入れる
    end

    if set_privilage == 0 then
      redirect_to "/home/index", alert: "not authenticated"
    end


  end

  def redirect_condition
    case self.controller_name
    when 'sessions'
      true
    when 'home'
      true
    else
      false
    end
  end


end

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_07_04_235936) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cmn_properties", comment: "属性情報", force: :cascade do |t|
    t.bigint "cmn_property_type_id"
    t.text "contents", null: false, comment: "属性値"
    t.boolean "is_active"
    t.text "staff_memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cmn_property_type_id"], name: "index_cmn_properties_on_cmn_property_type_id"
  end

  create_table "cmn_property_types", comment: "属性種別", force: :cascade do |t|
    t.string "title", null: false, comment: "属性のタイトル"
    t.text "description", comment: "属性に記載すべきものの説明"
    t.integer "property_datatype", default: 0, comment: "{string: 0, date:1 , datetime: 2, integer: 3, file:4, class_id:5}"
    t.string "data_class", comment: "property_datatype=5の時のクラス名. find(CmnProperty.contents)が属性"
    t.date "enable_date", comment: "有効日(入力可能開始日)"
    t.date "deprecated_date", comment: "入力非推奨開始日"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "control_privileges", force: :cascade do |t|
    t.bigint "privilege_group_id"
    t.string "controller_name"
    t.integer "privilege_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["privilege_group_id"], name: "index_control_privileges_on_privilege_group_id"
  end

  create_table "person_infos", comment: "共通人材情報", force: :cascade do |t|
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "kana_first_name"
    t.string "kana_middle_name"
    t.string "kana_last_name"
    t.text "memo", comment: "検索用情報項目"
    t.integer "user_status", default: 1, comment: "{0:無効, 1:有効}"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "privilege_groups", comment: "権限グループ", force: :cascade do |t|
    t.string "title"
    t.string "descriptions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_privilege_groups", comment: "ログインユーザー毎権限設定", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "privilege_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["privilege_group_id"], name: "index_user_privilege_groups_on_privilege_group_id"
    t.index ["user_id"], name: "index_user_privilege_groups_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "person_info_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cmn_properties", "cmn_property_types"
  add_foreign_key "control_privileges", "privilege_groups"
  add_foreign_key "user_privilege_groups", "privilege_groups"
  add_foreign_key "user_privilege_groups", "users"
end

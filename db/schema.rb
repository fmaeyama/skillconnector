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

ActiveRecord::Schema.define(version: 2018_10_28_212802) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", comment: "汎用住所項目", force: :cascade do |t|
    t.string "postal_code", comment: "郵便番号（ハイフン無し）"
    t.bigint "prefecture_id"
    t.string "address", comment: "市区町村以下番地まで"
    t.string "building", comment: "ビル名以下"
    t.string "about_this", comment: "アドレス説明"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prefecture_id"], name: "index_addresses_on_prefecture_id"
  end

  create_table "business_statuses", comment: "業務進行状態", force: :cascade do |t|
    t.string "name", comment: "表示名称"
    t.string "description", comment: "詳細"
    t.integer "sort_id", comment: "並び順"
    t.integer "group_id", comment: "表示制御グループ {prospective:0, active:1, resumed:2, expired:3}"
    t.boolean "status", comment: "表示フラグ cmn_enum.status"
    t.date "disable_from", default: "9999-12-31", comment: "新規利用停止日"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "business_types", comment: "業務種別", force: :cascade do |t|
    t.string "name", comment: "業務種別名称"
    t.bigint "parent_id", comment: "親業務種別"
    t.boolean "status", comment: "cmn_enum.status"
    t.date "disable_from", default: "9999-12-31", null: false, comment: "新規利用停止日"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_business_types_on_parent_id"
  end

  create_table "businesses", comment: "業務", force: :cascade do |t|
    t.string "name", null: false, comment: "業務タイトル"
    t.string "description", null: false, comment: "詳細内容"
    t.string "welcome", null: false, comment: "歓迎技術者"
    t.bigint "office_id", comment: "募集事業所"
    t.bigint "business_type_id", comment: "業務種別"
    t.bigint "business_status_id", comment: "募集状態"
    t.bigint "parent_business_id", comment: "親業務"
    t.integer "max_quantity", comment: "受入可能人数"
    t.integer "proper_quantity", comment: "希望募集人数"
    t.money "budget", scale: 2, comment: "予算"
    t.date "open_date", default: -> { "CURRENT_DATE" }, comment: "受付開始日"
    t.date "enable_date", default: -> { "CURRENT_DATE" }, comment: "受入可能日"
    t.date "end_date", default: "9999-12-31", comment: "受付締切日"
    t.date "expire_schedule", default: "9999-12-31", comment: "データ削除予定日"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_status_id"], name: "index_businesses_on_business_status_id"
    t.index ["business_type_id"], name: "index_businesses_on_business_type_id"
    t.index ["office_id"], name: "index_businesses_on_office_id"
    t.index ["parent_business_id"], name: "index_businesses_on_parent_business_id"
  end

  create_table "careers", comment: "経歴", force: :cascade do |t|
    t.bigint "engineer_id"
    t.bigint "skill_id"
    t.string "description", comment: "経歴詳細"
    t.date "career_from", comment: "経験歴（開始時期)"
    t.string "career_at", comment: "主な職場"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["engineer_id"], name: "index_careers_on_engineer_id"
    t.index ["skill_id"], name: "index_careers_on_skill_id"
  end

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

  create_table "contacts", comment: "汎用連絡先項目", force: :cascade do |t|
    t.string "contact_name", comment: "連絡先（人名等）"
    t.string "contact_kana", comment: "連絡先ふりがな"
    t.string "title", comment: "連絡先種別"
    t.integer "contact_type", default: 0, comment: "連絡先区分{email:0,tel:1,fax:2}"
    t.string "contact_value", comment: "アドレス、電話番号など"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts_offices", id: false, force: :cascade do |t|
    t.bigint "contact_id", null: false
    t.bigint "office_id", null: false
  end

  create_table "control_privileges", force: :cascade do |t|
    t.bigint "privilege_group_id"
    t.string "controller_name"
    t.integer "privilege_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["privilege_group_id"], name: "index_control_privileges_on_privilege_group_id"
  end

  create_table "engineer_hirings", comment: "技術者雇用所属(派遣元)", force: :cascade do |t|
    t.bigint "engineer_id"
    t.bigint "office_id", comment: "技術者雇用先（派遣元）"
    t.string "hiring_position", comment: "雇用先役職"
    t.string "hiring_division", comment: "雇用先所属"
    t.string "hiring_memo", comment: "技術者雇用メモ"
    t.bigint "hiring_contact_id", comment: "派遣元連絡先"
    t.date "hired_from", comment: "雇用開始時期"
    t.date "hired_until", comment: "退職(予定)日"
    t.integer "status", comment: "雇用関係"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["engineer_id"], name: "index_engineer_hirings_on_engineer_id"
    t.index ["hiring_contact_id"], name: "index_engineer_hirings_on_hiring_contact_id"
    t.index ["office_id"], name: "index_engineer_hirings_on_office_id"
  end

  create_table "engineer_hope_businesses", comment: "技術者志向", force: :cascade do |t|
    t.bigint "engineer_id"
    t.bigint "business_type_id", comment: "従事したい業務"
    t.bigint "skill_id", comment: "発揮したい技能"
    t.string "description", comment: "志望業務内容"
    t.date "hope_since", comment: "希望開始時期"
    t.integer "hope_strength", comment: "志向度合い"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_type_id"], name: "index_engineer_hope_businesses_on_business_type_id"
    t.index ["engineer_id"], name: "index_engineer_hope_businesses_on_engineer_id"
    t.index ["skill_id"], name: "index_engineer_hope_businesses_on_skill_id"
  end

  create_table "engineer_person_infos", comment: "技術者個人情報", force: :cascade do |t|
    t.bigint "engineer_id"
    t.bigint "person_info_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["engineer_id"], name: "index_engineer_person_infos_on_engineer_id"
    t.index ["person_info_id"], name: "index_engineer_person_infos_on_person_info_id"
  end

  create_table "engineer_registration_types", comment: "技術者流入種別", force: :cascade do |t|
    t.string "name", comment: "流入種別"
    t.string "description", comment: "流入種別詳細"
    t.integer "sort", comment: "並び順"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "engineer_status_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "sort"
    t.integer "group", comment: "表示フラグ, cmn_enum.group"
    t.date "disable_from", default: "9999-12-31"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "engineers", comment: "技術者", force: :cascade do |t|
    t.string "eng_cd", comment: "技術者登録コード"
    t.bigint "engineer_registration_type_id", comment: "技術者流入種別"
    t.string "registration_memo", comment: "流入情報補足"
    t.bigint "engineer_status_type_id", comment: "技術者紹介可能状況"
    t.bigint "person_info_id", comment: "技術者個人情報"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["engineer_registration_type_id"], name: "index_engineers_on_engineer_registration_type_id"
    t.index ["engineer_status_type_id"], name: "index_engineers_on_engineer_status_type_id"
    t.index ["person_info_id"], name: "index_engineers_on_person_info_id"
  end

  create_table "hat_levels", comment: "役割階層", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "constraint"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hat_supplements", force: :cascade do |t|
    t.string "hat_supplemental_type"
    t.bigint "hat_supplemental_id"
    t.string "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hat_supplemental_type", "hat_supplemental_id"], name: "index_hat_supplemental"
  end

  create_table "hat_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "hat_level_id"
    t.bigint "parent_hat_id"
    t.integer "status"
    t.date "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hat_level_id"], name: "index_hat_types_on_hat_level_id"
    t.index ["parent_hat_id"], name: "index_hat_types_on_parent_hat_id"
  end

  create_table "hats", comment: "役割", force: :cascade do |t|
    t.bigint "hat_type_id", comment: "役割種別"
    t.string "hat_reference_type"
    t.bigint "hat_reference_id", comment: "役割参照元"
    t.string "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hat_reference_type", "hat_reference_id"], name: "index_hats_on_hat_reference_type_and_hat_reference_id"
    t.index ["hat_type_id"], name: "index_hats_on_hat_type_id"
  end

  create_table "offer_skills", comment: "求人に必要な技能", force: :cascade do |t|
    t.bigint "offer_id"
    t.bigint "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_offer_skills_on_offer_id"
    t.index ["skill_id"], name: "index_offer_skills_on_skill_id"
  end

  create_table "offer_statuses", comment: "求人状況", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "sort"
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_offer_statuses_on_parent_id"
  end

  create_table "offers", comment: "求人", force: :cascade do |t|
    t.bigint "business_id", comment: "事業"
    t.string "title", comment: "案件名"
    t.string "description"
    t.bigint "offer_status_id", comment: "求人状況"
    t.date "start_from", default: -> { "CURRENT_DATE" }
    t.date "want_until", default: "9999-12-31", comment: "募集終了日"
    t.string "work_at", comment: "Work at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_offers_on_business_id"
    t.index ["offer_status_id"], name: "index_offers_on_offer_status_id"
  end

  create_table "office_statuses", comment: "事業所契約状態", force: :cascade do |t|
    t.string "name", comment: "表示名称"
    t.string "description", comment: "詳細"
    t.integer "sort_id", comment: "並び順"
    t.integer "group_id", comment: "表示制御グループ {prospective:0, active:1, resumed:2, expired:3}"
    t.boolean "status", comment: "表示フラグ cmn_enum.status"
    t.date "disable_from", default: "9999-12-31", comment: "新規利用停止日"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "office_types", comment: "事業所種別", force: :cascade do |t|
    t.string "name", comment: "事業所種別名称"
    t.boolean "status", comment: "cmn_enum.status"
    t.date "disable_from", default: "9999-12-31", null: false, comment: "新規利用停止日"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offices", comment: "事業所", force: :cascade do |t|
    t.string "cd", null: false, comment: "事業所CODE"
    t.string "name", null: false, comment: "事業所名称"
    t.string "name_kana", null: false, comment: "事業所読み仮名"
    t.string "long_name", null: false, comment: "事業所正式名称"
    t.string "long_name_kana", null: false, comment: "事業所正式名称読み仮名"
    t.bigint "parent_id", comment: "上位事業所"
    t.bigint "office_type_id", comment: "事業所種別"
    t.bigint "primary_address_id", comment: "代表住所"
    t.bigint "primary_contact_id", comment: "代表連絡先"
    t.bigint "office_status_id", comment: "事業所契約状態"
    t.date "enable_date", default: -> { "CURRENT_DATE" }, comment: "利用開始日"
    t.date "end_date", default: "9999-12-31", comment: "休止日"
    t.date "expire_schedule", default: "9999-12-31", comment: "データ削除予定日"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cd"], name: "index_offices_on_cd", unique: true
    t.index ["office_status_id"], name: "index_offices_on_office_status_id"
    t.index ["office_type_id"], name: "index_offices_on_office_type_id"
    t.index ["parent_id"], name: "index_offices_on_parent_id"
    t.index ["primary_address_id"], name: "index_offices_on_primary_address_id"
    t.index ["primary_contact_id"], name: "index_offices_on_primary_contact_id"
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

  create_table "prefectures", comment: "都道府県", force: :cascade do |t|
    t.string "name", comment: "都道府県名"
    t.string "name_e"
    t.string "name_h"
    t.string "name_k"
    t.string "area"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "privilege_groups", comment: "権限グループ", force: :cascade do |t|
    t.string "title"
    t.string "descriptions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "proposals", comment: "提案", force: :cascade do |t|
    t.bigint "offer_id", comment: "求人"
    t.bigint "engineer_id", comment: "技術者"
    t.bigint "offered_staff_id", comment: "担当スタッフ"
    t.bigint "office_contact_id", comment: "Office contacts"
    t.string "history"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["engineer_id"], name: "index_proposals_on_engineer_id"
    t.index ["offer_id"], name: "index_proposals_on_offer_id"
    t.index ["offered_staff_id"], name: "index_proposals_on_offered_staff_id"
    t.index ["office_contact_id"], name: "index_proposals_on_office_contact_id"
  end

  create_table "skill_connects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skill_levels", comment: "技能階層", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "constraint"
  end

  create_table "skill_supplements", force: :cascade do |t|
    t.string "skill_supplemental_type"
    t.bigint "skill_supplemental_id"
    t.string "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_supplemental_type", "skill_supplemental_id"], name: "index_skill_supplementals"
  end

  create_table "skill_types", comment: "技能種別", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "skill_level_id", comment: "技能階層"
    t.bigint "parent_skill_id", comment: "技能グループ"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "deleted_at"
    t.index ["parent_skill_id"], name: "index_skill_types_on_parent_skill_id"
    t.index ["skill_level_id"], name: "index_skill_types_on_skill_level_id"
  end

  create_table "skills", comment: "技能", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "skill_type", comment: "技能種別"
    t.string "skill_reference_type"
    t.bigint "skill_reference_id", comment: "技能参照元"
  end

  create_table "staffs", comment: "SKILLCONNECTメンバー", force: :cascade do |t|
    t.bigint "person_info_id"
    t.string "history"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "staff_cd", comment: "スタッフコード"
    t.date "enable_from", comment: "入職（予定）日"
    t.date "disable_from", default: "9999-12-31", comment: "離職日"
    t.integer "status", comment: "staff_enum.staff_status"
    t.index ["person_info_id"], name: "index_staffs_on_person_info_id"
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

  add_foreign_key "business_types", "business_types", column: "parent_id"
  add_foreign_key "businesses", "offices"
  add_foreign_key "careers", "engineers"
  add_foreign_key "cmn_properties", "cmn_property_types"
  add_foreign_key "control_privileges", "privilege_groups"
  add_foreign_key "engineer_hirings", "contacts", column: "hiring_contact_id"
  add_foreign_key "engineer_hirings", "engineers"
  add_foreign_key "engineer_hirings", "offices"
  add_foreign_key "engineer_hope_businesses", "business_types"
  add_foreign_key "engineer_hope_businesses", "engineers"
  add_foreign_key "engineer_hope_businesses", "skills"
  add_foreign_key "engineer_person_infos", "engineers"
  add_foreign_key "engineer_person_infos", "person_infos"
  add_foreign_key "engineers", "engineer_registration_types"
  add_foreign_key "engineers", "engineer_status_types"
  add_foreign_key "engineers", "person_infos"
  add_foreign_key "offer_skills", "offers"
  add_foreign_key "offer_skills", "skills"
  add_foreign_key "offer_statuses", "offer_statuses", column: "parent_id"
  add_foreign_key "offers", "businesses"
  add_foreign_key "offers", "offer_statuses"
  add_foreign_key "offices", "addresses", column: "primary_address_id"
  add_foreign_key "offices", "contacts", column: "primary_contact_id"
  add_foreign_key "offices", "offices", column: "parent_id"
  add_foreign_key "proposals", "contacts", column: "office_contact_id"
  add_foreign_key "proposals", "engineers"
  add_foreign_key "proposals", "offers"
  add_foreign_key "proposals", "staffs", column: "offered_staff_id"
  add_foreign_key "skill_types", "skill_levels"
  add_foreign_key "skill_types", "skill_types", column: "parent_skill_id"
  add_foreign_key "staffs", "person_infos"
  add_foreign_key "user_privilege_groups", "privilege_groups"
  add_foreign_key "user_privilege_groups", "users"
end

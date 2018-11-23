require 'test_helper'

class SkillTest < ActiveSupport::TestCase
  setup do
    @var = BusinessDecorator.new
  end

  def self.create_business(id)
    office = Office.find_or_create_by(cd: "TEST001", name: "TESTname", name_kana: "てすとかな",
      long_name: "TestLongName", long_name_kana: "ながいなまえのかな",
      office_status_id: 1, office_type_id: 1)
    bus = Business.where(id: 1)
    if bus.none?
      bus = Business.new(id: id, "business_status_id" => "2",
        "business_type_id" => "2",
        "name" => "POSレジ開発",
        "description" => "顧客管理システムの開発です",
        "welcome" => "要件定義、COBOL",
        "max_quantity" => "3",
        "proper_quantity" => "3",
        "budget" => "1000000.0")
      bus.office = office
      bus.save!
    end
    bus
  end

  test "check skill supplement updater" do
    param = ActionController::Parameters.new(
      {"utf8" => "✓",
        "_method" => "patch",
        "authenticity_token" => "7tBgIYSt2wi8DjrUvnrqZ8Oo1vhGkUnlZJ3dbB1poxzq+zx/hs57HBCsjCq0jp9Oc1Kw0YANoCF7Jn+FaEaviA==",
        "business" =>
          {"business_status_id" => "2",
            "business_type_id" => "2",
            "name" => "POSレジ開発",
            "description" => "顧客管理システムの開発です",
            "welcome" => "要件定義、COBOL",
            "max_quantity" => "3",
            "proper_quantity" => "3",
            "budget" => "1000000.0",
            "office_id" => "2"},
        "hat" =>
          {"1" =>
            {"0" =>
              {"hat_type_id" => "1", "memo" => "備考のテスト", "id" => "1", "_destroy" => "0"}},
          "2" =>
            {"0" =>
              {"hat_type_id" => "3", "memo" => "備考", "id" => "3", "_destroy" => "0"},
            "1" =>
              {"hat_type_id" => "4", "memo" => "", "id" => "2", "_destroy" => "0"}},
          "hat_supplement" => {"memo" => "役割補足の備考なんです", "id" => "1"}},
        "skill" =>
          {"1" =>
            {"0" =>
              {"skill_type_id" => "1", "memo" => "", "id" => "-1", "_destroy" => "0"}
            },
            "2" =>
              {"0" =>
                {"skill_type_id" => "6", "memo" => "", "id" => "-1", "_destroy" => "0"}
              },
            "3" =>
              {"0" =>
                {"skill_type_id"=>"13", "trained_type_id"=>"2", "memo"=>"", "id"=>"-1", "_destroy"=>"0"}
              },
            "skill_supplement" =>
              {"memo" => "技術の補足", "id" => "5"}
          },
        "commit" => "案件更新",
        "id" => "3"}
    )
    SkillTest.create_business 3
    Skill.update_by_reference Business, 3, param, @var
  end

  test "check skill container for new object" do
    hl = @var.skill_levels
    puts "　**  test .. check for skill_levels"

    assert_equal hl[1].name, 'スキル1'
    assert_equal hl[2].name, 'スキル2'
    assert_equal hl[3].name, 'スキル3'

    puts "check for skill_types"
    ht = @var.skill_types
    assert_equal ht.size, 3

    assert true
  end


  test "check hat_hash method for new Business" do
    skill_array = Skill.skills_hash Business, -1, @var, Hash.new
    puts "　○　check for hat_hash result"
    skill_level = 1
    business_id = -1
    sl = skill_array[Business][business_id][:levels][skill_level][0]
#        pp @var.skill_levels
#        pp sl.level.constraint_before_type_cast

    assert_equal skill_array[Business][business_id][:levels].size, 3
    assert_equal skill_array[Business][business_id][:levels][skill_level][0].level.id, 1
    assert skill_array[Business][business_id][:levels][skill_level][0].level.required?
    assert_not skill_array[Business][business_id][:levels][skill_level][0].level.multi?
    assert_nil skill_array[Business][business_id][:levels][skill_level][0].skill_type

  end

end

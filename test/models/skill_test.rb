require 'test_helper'

class SkillTest < ActiveSupport::TestCase
    setup do
        @var = BusinessDecorator.new
    end

    test "check skill container for new object" do
        hl = @var.skill_levels
        puts "　**  test .. check for skill_levels"

        assert_equal hl[1].name, 'スキル1'
        assert_equal hl[2].name, 'スキル2'
        assert_equal hl[3].name, 'スキル3'

        puts "check for skil_types"
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

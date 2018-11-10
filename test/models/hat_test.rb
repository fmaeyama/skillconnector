require 'test_helper'

class HatTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end

    setup do
        @var = BusinessDecorator.new
    end

    test "check hat container for new object" do
        hl = @var.hat_levels
        puts "　**  test .. check for hat_levels"

        assert_equal hl[1].name, '役割1'
        assert_equal hl[2].name, '役割2'

        puts "check for hat_types"
        ht = @var.hat_types
        p ht
        assert_equal ht.size, 2


        assert true
    end


    test "check hat_hash method for existed Business with no Hats" do
        puts "　**  test hat_hash method for existed Business with no Hats"

        office = Office.find_or_create_by(cd: "TEST001", name: "TESTname", name_kana: "てすとかな",
            long_name: "TestLongName", long_name_kana: "ながいなまえのかな",
            office_status_id: 1, office_type_id: 1)
        bus = Business.where(id: 1)
        p bus
        if bus.none?
            bus = Business.new(id: 1, "business_status_id" => "2",
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

        hs = bus.build_hat_supplement
        hs.memo = "test"
        hs.save!

        p hs

        hat_array = Hat.hats_hash Business, 1, @var, Hash.new
        hat_array[Business][:levels].each do |hl_key, hl_val|
            p hl_val
            hl_val.each do |hat|
                p hat.hat_type
            end
        end

        assert_equal hat_array[Business][:levels].size, 2
        assert_equal hat_array[Business][:levels][1][0].level.id, 1
        assert_nil hat_array[Business][:levels][1][0].hat_type
        assert_equal hat_array[Business][:levels][2][0].level.id, 2
        assert_nil hat_array[Business][:levels][2][0].hat_type

    end

    test "check hat_hash method for new Business" do
        hat_array = Hat.hats_hash Business, -1, @var
        puts "　○　check for hat_hash result"
        p hat_array

        assert_equal hat_array[Business][:levels].size, 2
        assert_equal hat_array[Business][:levels][1][0].level.id, 1
        assert_nil hat_array[Business][:levels][1][0].hat_type
        assert_equal hat_array[Business][:levels][2][0].level.id, 2
        assert_nil hat_array[Business][:levels][2][0].hat_type

    end

    test 'check basic save method with reference model' do
        puts " ** check basic save method with reference model"
        params = ActionController::Parameters.new({
            business:
                {"business_status_id" => "2",
                    "business_type_id" => "2",
                    "name" => "POSレジ開発",
                    "description" => "顧客管理システムの開発です",
                    "welcome" => "要件定義、COBOL",
                    "max_quantity" => "3",
                    "proper_quantity" => "3",
                    "budget" => "1000000.0",
                    "office_id" => "2"},
            hat: {
                "1" => {"0" => {"id" => -1, "hat_type_id" => "1", "memo" => "特に意味は無い", "_destroy" => "0"},
                    "new-1540288340189" => {"id" => -1, "hat_type_id" => "", "memo" => "", "_destroy" => "1"}},
                "2" => {"0" => {"id" => -1, "hat_type_id" => "3", "memo" => "", "_destroy" => "0"},
                    "new-1540288348375" => {"id" => -1, "hat_type_id" => "4", "memo" => "", "_destroy" => "0"}}
            }})

        @office = Office.new
        @office.attributes = {cd: "TEST001", name: "TESTname", name_kana: "てすとかな",
            long_name: "TestLongName", long_name_kana: "ながいなまえのかな",
            office_status_id: 1, office_type_id: 1}
        @office.save!
        @bus = Business.new
        @bus.attributes = Business.business_params(params, :business)
        @bus.office_id = @office.id
        Business.transaction do
            @bus.save!
            Hat.update_by_reference(Business, @bus.id, params, @var)
        end

    end

end

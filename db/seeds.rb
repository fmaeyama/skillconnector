# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

CmnPropertyType.find_or_create_by(
		title:'住所・郵便番号',
		description: '都道府県、住所、郵便番号はaddressモデルからの取得とする',
		property_datatype: :class_id,
		data_class: 'address'
)

CmnPropertyType.find_or_create_by(
		title:'生年月日',
		description: '誕生日の場合、年については0000',
		property_datatype: :date
)

privGroup=PrivilegeGroup.find_or_create_by(
									title: 'system admin',
									descriptions: 'サイト管理スタッフ'
)

ControlPrivilege.find_or_create_by(
										privilege_group_id: privGroup.id,
										controller_name: 'home',
										privilege_type: :allow_all
)

privGroup=PrivilegeGroup.find_or_create_by(
		title: 'biz admin',
		descriptions: '企業ユーザー'
)

ControlPrivilege.find_or_create_by(
		privilege_group_id: privGroup.id,
		controller_name: 'home',
		privilege_type: :allow_all
)


privGroup=PrivilegeGroup.find_or_create_by(
		title: 'usr',
		descriptions: 'エンジニア'
)

ControlPrivilege.find_or_create_by(
		privilege_group_id: privGroup.id,
		controller_name: 'home',
		privilege_type: :allow_all
)

Dir.glob("#{Rails.root}/db/seeds/*.yml").each do |yaml_filename|

	puts yaml_filename

	targetmodel=File.basename(yaml_filename,".yml").classify.constantize
	ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{targetmodel.table_name} CASCADE")

	File.open(yaml_filename) do |load_target_yaml|
		records = YAML.load(load_target_yaml)
		records.each do |record|
			puts record
			if record.has_key? "sql"
				ActiveRecord::Base.connection.execute(record["sql"])
			else
				model = targetmodel.create(record)
				model.save!
			end
		end
	end
end
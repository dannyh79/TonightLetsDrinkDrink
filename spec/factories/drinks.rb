FactoryBot.define do
  factory :drink do
    name { Faker::Name.name }
    volume_alcohol { Faker::Number.between(0, 100) }
    img_path { '' }
  end
end

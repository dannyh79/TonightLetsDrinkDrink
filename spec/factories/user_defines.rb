FactoryBot.define do
  factory :user_define do
    name { Faker::Name.name }
    user_id { Faker::Number.between(1, 10) }
    drink_id { [ Faker::Number.between(1, 10), Faker::Number.between(1, 10), Faker::Number.between(1, 10) ] }
    ratio { [ Faker::Number.between(1, 10), Faker::Number.between(1, 10), Faker::Number.between(1, 10) ] }
    ingredient_volume_alcohol { [ Faker::Number.between(1, 10), Faker::Number.between(1, 10), Faker::Number.between(1, 10) ] }
  end
end
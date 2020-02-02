# frozen_string_literal: true

FactoryBot.define do
  factory :drink do
    name { Faker::Name.name }
    display_name { Faker::Name.name }
    volume_alcohol { Faker::Number.between(0, 100) }
    img_path { '' }
  end
end

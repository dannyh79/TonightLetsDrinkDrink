# frozen_string_literal: true

FactoryBot.define do
  # FIXME: Refactor me
  factory :user_define do
    one2ten = Faker::Number.between(1, 10)
    name { Faker::Name.name }
    user_id { one2ten }
    drink_id { [one2ten, one2ten, one2ten] }
    ratio { [one2ten, one2ten, one2ten] }
    ingredient_volume_alcohol { [one2ten, one2ten, one2ten] }
  end
end

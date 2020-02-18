# frozen_string_literal: true

require 'rails_helper'

# FIXME: Refactor me
RSpec.describe UserDefine, type: :model do
  it "total concentration derived from ratio must match the expected" do
    User.create(
      id: 1,
      email: '111@222.com',
      password: '111111',
      gender: Faker::Boolean.boolean
    )
    ud1 = create(
      :user_define,
      user_id: 1,
      name: 'good cock-tail',
      drink_id: %w[2 4],
      ratio: %w[3 1],
      ingredient_volume_alcohol: %w[0 40]
    )
    ud2 = create(
      :user_define,
      user_id: 1,
      name: 'very good cock-tail',
      drink_id: %w[2 4 1],
      ratio: %w[3 1 6],
      ingredient_volume_alcohol: ["0", "40", "4.5"]
    )

    expect(ud1.volume_alcohol).to eq 10
    expect(ud2.volume_alcohol).to eq 6.7
  end
end

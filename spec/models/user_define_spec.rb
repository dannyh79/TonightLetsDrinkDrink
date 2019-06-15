require 'rails_helper'

RSpec.describe UserDefine, type: :model do
  it "total concentration derived from ratio must match the expected" do
    ud1 = UserDefine.new('good cock-tail', [2, 4], [3, 1], [0, 40])
    ud2 = UserDefine.new('very good cock-tail', [2, 4, 1], [3, 1, 6], [0, 40, 4.5])

    expect(ud1.volume_alcohol).to eq 10
    expect(ud2.volume_alcohol).to eq 6.7
  end
end

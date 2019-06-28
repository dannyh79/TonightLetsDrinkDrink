require 'rails_helper'

RSpec.describe Drink, type: :model do
  describe 'basics' do
    it 'a drink has "name", "display_name", and "volume_alcohol"' do
      should validate_presence_of(:name)
      should validate_presence_of(:display_name)
      should validate_presence_of(:volume_alcohol)
    end
    it 'drink\'s volume_alcohol is between 0 and 100' do
      should validate_inclusion_of(:volume_alcohol).in_range(0..100)
    end
  end
end

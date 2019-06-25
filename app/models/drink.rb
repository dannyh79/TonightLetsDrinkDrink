class Drink < ApplicationRecord
  validates :name, :volume_alcohol, :display_name, presence: true
end

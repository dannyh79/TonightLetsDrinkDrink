# frozen_string_literal: true

class Drink < ApplicationRecord
  validates :name, :volume_alcohol, :display_name, presence: true
  validates :volume_alcohol, inclusion: 0..100
end

# frozen_string_literal: true

class UserDefine < ApplicationRecord
  belongs_to :user

  # FIXME: Rename :ingredient_volume_alcohol
  validates :drink_id,                  presence: true
  validates :ingredient_volume_alcohol, presence: true
  validates :name,                      presence: true
  validates :ratio,                     presence: true
  validates :user_id,                   presence: true

  # TODO: Refactor method & name to make it descriptive
  def volume_alcohol
    # hashing the 2 arrays, "ratio" & "ingredient_volume_alcohol"
    # into one 2-d array of hashes
    array_ratio = ratio.map { |ingredient_ratio| { ratio: ingredient_ratio } }
    array_volume_alcohol = ingredient_volume_alcohol
                           .map do |ingredient_volume_alcohol|
                             { volume_alcohol: ingredient_volume_alcohol }
                           end
    hash_combined = hashing_value_from_2_arrays(
      array_ratio,
      array_volume_alcohol
    )

    # weighted average for the result
    # - the total of each ingredient's "ratio * volume_alcohol"
    numerator = hash_combined.reduce(0) do |accumulator, sub_hash|
      accumulator + sub_hash[:ratio].to_f * sub_hash[:volume_alcohol].to_f
    end

    # - the sum of all ingredient's ratio
    denominator = hash_combined.reduce(0) do |accumulator, sub_hash|
      accumulator + sub_hash[:ratio].to_f
    end

    (numerator / denominator).round(2)
  end

  private

  # TODO: Refactor method & name to make it descriptive
  def hashing_value_from_2_arrays(array1, array2)
    return 'invalid' if array1.count != array2.count

    result = []

    # the repeat times for the iterator
    repeat = array1.count

    repeat.times do
      hash_of_array1 = array1.shift
      hash_of_array2 = array2.shift

      result << {
        ratio: hash_of_array1[:ratio],
        volume_alcohol: hash_of_array2[:volume_alcohol]
      }
    end

    result
  end
end

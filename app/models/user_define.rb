class UserDefine < ApplicationRecord
  validates :name, :user_id, :drink_id, :ingredient_volume_alcohol, :ratio, presence: true
  belongs_to :user

  def volume_alcohol
    # hashing the 2 arrays, "ratio" & "ingredient_volume_alcohol", into one 2-d array of hashes
    array_ratio = self.ratio.map { |ingredient_ratio| { ratio: ingredient_ratio } }
    array_volume_alcohol = self.ingredient_volume_alcohol.map { |ingredient_volume_alcohol| { volume_alcohol: ingredient_volume_alcohol } }
    hash_combined = hashing_value_from_2_arrays(array_ratio, array_volume_alcohol)
    

    # weighted average for the result
    # - the total of each ingredient's "ratio * volume_alcohol"
    numerator = hash_combined.reduce(0) { |accumulator, sub_hash| accumulator + sub_hash[:ratio].to_f * sub_hash[:volume_alcohol].to_f }

    # - the sum of all ingredient's ratio
    denominator = hash_combined.reduce(0) { |accumulator, sub_hash| accumulator + sub_hash[:ratio].to_f }
    
    
    result = (numerator / denominator).round(2)
  end


  private 

  def hashing_value_from_2_arrays(array1, array2)
    return 'invalid' if not array1.count == array2.count
    result = []

    # the repeat times for the iterator
    repeat = array1.count
    
    repeat.times {
      hash_of_array1 = array1.shift
      hash_of_array2 = array2.shift

      result << { ratio: hash_of_array1[:ratio], volume_alcohol: hash_of_array2[:volume_alcohol] }
    }

    result
  end
end

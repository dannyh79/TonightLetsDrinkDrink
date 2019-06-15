# *****Issue: UserDefine's instance can NOT be created if the class is inherited from ApplicationRecord
# currently ApplicationRecord is "closed" so to make UserDefine PORO
class UserDefine #< ApplicationRecord
#  belongs_to :user

  attr_reader :name, :drink_id, :ratio, :ingredient_volume_alcohol

  def initialize(name = '', drink_id = [], ratio = [], ingredient_volume_alcohol = [])
    @name = name
    @drink_id = drink_id
    @ratio = ratio
    @ingredient_volume_alcohol = ingredient_volume_alcohol
  end

  def volume_alcohol
    # hashing the 2 arrays, "ratio" & "ingredient_volume_alcohol", into one 2-d array of hashes
    array_ratio = self.ratio.map { |ingredient_ratio| { ratio: ingredient_ratio } }
    array_volume_alcohol = self.ingredient_volume_alcohol.map { |ingredient_volume_alcohol| { volume_alcohol: ingredient_volume_alcohol } }
    hash_combined = hashing_value_from_2_arrays(array_ratio, array_volume_alcohol)
    

    # weighted average for the result
    # - the total of each ingredient's "ratio * volume_alcohol"
    numerator = hash_combined.reduce(0) { |accumulator, sub_hash| accumulator + sub_hash[:ratio] * sub_hash[:volume_alcohol] }

    # - the sum of all ingredient's ratio
    denominator = hash_combined.reduce(0) { |accumulator, sub_hash| accumulator + sub_hash[:ratio] }
    
    
    # - use ".to_f" to force the result as decimal, if the case
    result = numerator.to_f / denominator    
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

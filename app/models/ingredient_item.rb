# 等同於 CartItem
class IngredientItem
  attr_reader :drink_id, :ratio, :volume_alcohol

  def initialize(drink_id, ratio = 1, volume_alcohol = 0)
    @drink_id = drink_id
    @ratio = ratio
    @volume_alcohol = volume_alcohol
  end

  # 搜尋材料的名字
  def name(drink_id)
    Drink.find_by(id: drink_id).name
  end
end
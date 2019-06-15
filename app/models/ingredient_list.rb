# 等同於 "Cart"
class IngredientList
  attr_reader :ingredients

  def initialize(ingredients = [])
    @ingredients = ingredients
  end

  def add(ingredient)
    ingredients << IngredientItem.new(ingredient[:drink_id], ingredient[:ratio], ingredient[:volume_alcohol])
  end

  def self.content(session)
    if session
      IngredientList.new(session)
    else
      IngredientList.new
    end
  end

  def delete(ingredient_index)
    ingredients.delete_at(ingredient_index) if ingredient_index
  end

end
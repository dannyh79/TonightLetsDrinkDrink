# frozen_string_literal: true

# FIXME: Refactor methods
# 等同於 "Cart"
class IngredientList
  attr_reader :ingredients

  def initialize(ingredients = [])
    @ingredients = ingredients
  end

  def add(ingredient)
    ingredients << {
      'drink_id': ingredient['drink_id'],
      'ratio': ingredient['ratio'],
      'volume_alcohol': ingredient['volume_alcohol']
    }
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

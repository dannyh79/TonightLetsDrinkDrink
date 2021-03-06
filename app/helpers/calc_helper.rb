# frozen_string_literal: true

# FIXME: Refactor below methods
module CalcHelper
  def drinks
    Drink.all
  end

  def ingredient_list
    @ingredient_list ||= IngredientList.content(session[:yo])
  end

  # 搜尋材料的名字
  def name(drink_id)
    Drink.find_by(id: drink_id).display_name
  end

  def image(drink_id)
    Drink.find_by(id: drink_id).img_path
  end
end

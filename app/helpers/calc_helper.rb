module CalcHelper
  def drinks
    Drink.all
  end

  def ingredient_list
    @ingredient_list ||= IngredientList.content(session[:yo])
  end
end
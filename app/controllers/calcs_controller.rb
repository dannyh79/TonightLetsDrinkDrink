class CalcsController < ApplicationController
  include CalcHelper

  def show
    @drinks = drinks
    # 先做假資料
    gon.current_user_gender = current_user.gender
    gon.current_user_weight = current_user.weight
  end
  
end

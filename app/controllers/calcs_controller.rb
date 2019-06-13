class CalcsController < ApplicationController
  include CalcHelper

  def show
    @drinks = drinks
    # 先做假資料
    gon.current_user_gender = 0
    gon.current_user_weight = 70
  end
  
end

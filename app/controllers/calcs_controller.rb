class CalcsController < ApplicationController
  include CalcHelper

  def show
    @drinks = drinks

    gon.current_user_gender = current_user.gender
    gon.current_user_weight = current_user.weight
  end

  def user_define
    @drinks = drinks
  end

  def record_user_define
    @drinks = drinks
  end


  # 新增材料至 session 中的 ":yo" key 的 value
  def add_ingredient
    # 從前頁收參數
    received_parameter = params_ingredient

    # 於 session 內加料
    session[:yo] = ingredient_list.add(received_parameter)
  end
  

  private

  # ingredient 用的 strong parameters
  def params_ingredient
    params.permit(:drink_id, :ratio, :volume_alcohol)
  end

end

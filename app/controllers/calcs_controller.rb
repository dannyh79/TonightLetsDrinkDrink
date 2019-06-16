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

  # def record_user_define
  #   @drinks = drinks

  #   if session[:yo] != nil
  #     @ingredient_volume_alcohol = make_array_of("float", session[:yo], "volume_alcohol")
  #   end
  # end


  # 調酒材料儲存至 session[:yo]
  def add_ingredient
    # 從前頁收參數
    received_parameter = params_ingredient

    # 於 session 內"加料"
    session[:yo] = ingredient_list.add(received_parameter)

    redirect_to user_define_calc_path
  end
  
  def delete_ingredient
    session[:yo].delete_at(params["id"].to_i)
    redirect_to user_define_calc_path
  end


  private

  # ingredient 用的 strong parameters
  def params_ingredient
    params.permit(:drink_id, :ratio, :volume_alcohol)
  end


end

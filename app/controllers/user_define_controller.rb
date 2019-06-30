class UserDefineController < ApplicationController
  include CalcHelper

  def destroy
    user_define = UserDefine.find_by(id: params[:id])
    
    if user_define.destroy
      redirect_to record_user_define_calc_path, notice: '調酒紀錄已刪除'
    end
  end
  
  def create
    user_define = UserDefine.new(params_user_define)
    
    if session[:yo] != nil
      user_define[:drink_id] = array_of("integer", session[:yo], "drink_id")
      user_define[:ingredient_volume_alcohol] = array_of("integer", session[:yo], "volume_alcohol")
      user_define[:ratio] = array_of("integer", session[:yo], "ratio")
    end
    
    if user_define.save
      session[:yo] = nil
      redirect_to record_user_define_calc_path, notice: '新增調酒成功'
    else
      # need designated error msg area on "/calc", "/calc/record_user_define", "/calc/user_define" when there is error
      redirect_to '/calc/user_define'
    end
  end


  # 調酒材料儲存至 session[:yo]
  def add_ingredient
    # 從前頁收參數
    received_parameter = params_ingredient

    if received_parameter["ratio"] != "" && received_parameter["volume_alcohol"] != ""
      # 於 session 內"加料"
      session[:yo] = ingredient_list.add(received_parameter)

      redirect_to user_define_calc_path, notice: '品項新增成功'
    else
      redirect_to user_define_calc_path, notice: '沒填好ㄛ'
    end
  end
  
  def delete_ingredient
    session[:yo].delete_at(params["id"].to_i)
    redirect_to user_define_calc_path, notice: '品項刪除成功'
  end



  

  private

  # ingredient 用的 strong parameters
  def params_ingredient
    params.permit(:drink_id, :ratio, :volume_alcohol)
  end

  def params_user_define
    params.permit(:user_id, :name, :drink_id, :ingredient_volume_alcohol, :ratio)
  end

  def array_of(type = "float", array_of_hashs, key)
    result = []

    if array_of_hashs != nil
      case type
      when "float"
        array_of_hashs.each { |hash| result << hash[key].to_f }
      when "integer"
        array_of_hashs.each { |hash| result << hash[key].to_i }
      end
    end
    return result
  end
end
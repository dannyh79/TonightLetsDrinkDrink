class UserDefineController < ApplicationController

  def edit
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
      redirect_to record_user_define_calc_path
    else
      # need designated error msg area on "/calc", "/calc/record_user_define", "/calc/user_define" when there is error
      redirect_to '/calc/user_define'
    end
  end


  private

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
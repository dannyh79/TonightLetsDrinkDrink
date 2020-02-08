# frozen_string_literal: true

# FIXME: session[:yo]
class UserDefineController < ApplicationController
  include CalcHelper

  def destroy
    user_define = UserDefine.find_by(id: params[:id])

    return unless user_define.destroy

    redirect_to record_user_define_calc_path, notice: '調酒紀錄已刪除'
  end

  def create
    user_define = UserDefine.new(params_user_define)

    unless session[:yo].nil?
      user_define[:drink_id] = array_of(session[:yo], 'drink_id', 'integer')
      user_define[:ingredient_volume_alcohol] = array_of(
        session[:yo], 'volume_alcohol', 'integer'
      )
      user_define[:ratio] = array_of(session[:yo], 'ratio', 'integer')
    end

    if user_define.save
      session[:yo] = nil
      redirect_to record_user_define_calc_path, notice: '新增調酒成功'
    else
      # need designated error msg area on when there is error
      # "/calc",
      # "/calc/record_user_define",
      # "/calc/user_define"
      redirect_to '/calc/user_define'
    end
  end

  # 調酒材料儲存至 session[:yo]
  def add_ingredient
    # 從前頁收參數
    received_params = params_ingredient

    if received_params['ratio'] != '' && received_params['volume_alcohol'] != ''
      # 於 session 內"加料"
      session[:yo] = ingredient_list.add(received_params)

      redirect_to user_define_calc_path, notice: '品項新增成功'
    else
      redirect_to user_define_calc_path
    end
  end

  def delete_ingredient
    session[:yo].delete_at(params['id'].to_i)
    redirect_to user_define_calc_path, notice: '品項刪除成功'
  end

  private

  # TODO: Unify naming pattern for strong params
  def params_ingredient
    params.permit(:drink_id, :ratio, :volume_alcohol)
  end

  # TODO: Unify naming pattern for strong params
  def params_user_define
    params.permit(
      :user_id,
      :name,
      :drink_id,
      :ingredient_volume_alcohol,
      :ratio
    )
  end

  # FIXME: Nested if statement
  def array_of(array_of_hashs, key, type = 'float')
    result = []

    unless array_of_hashs.nil?
      case type
      when 'float'
        array_of_hashs.each { |hash| result << hash[key].to_f }
      when 'integer'
        array_of_hashs.each { |hash| result << hash[key].to_i }
      end
    end
    result
  end
end

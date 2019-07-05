class CalcsController < ApplicationController
  include CalcHelper
  before_action :authenticate_user!
  before_action :export_user_gender_weight
  before_action :user_info_complete?, only: :show

  def show
    @drinks = drinks
  end

  def user_define
    @drinks = drinks
  end

  private

  def export_user_gender_weight
    gon.current_user_gender = current_user.gender
    gon.current_user_weight = current_user.weight
  end

  # 在這個 action 之前應該要先 render 到編輯個人頁（判斷資料是不是完整）
  def user_info_complete?
    if  current_user.weight == 1
      redirect_to user_profile_path, notice: '請填寫性別與體重'
    end
  end

end

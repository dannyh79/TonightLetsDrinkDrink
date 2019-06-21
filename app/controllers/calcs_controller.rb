class CalcsController < ApplicationController
  include CalcHelper
  before_action :authenticate_user!
  before_action :export_user_gender_weight

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
end

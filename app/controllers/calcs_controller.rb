class CalcsController < ApplicationController
  include CalcHelper

  before_action :gon_lin_lao_mu

  def show
    @drinks = drinks
  end

  def user_define
    @drinks = drinks
  end

  private

  def gon_lin_lao_mu
    gon.current_user_gender = current_user.gender
    gon.current_user_weight = current_user.weight
  end
end

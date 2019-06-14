class CalcsController < ApplicationController
  include CalcHelper

  def show
    @drinks = drinks

    gon.current_user_gender = current_user.gender
    gon.current_user_weight = current_user.weight
  end
  
end

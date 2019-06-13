class CalcsController < ApplicationController
  include CalcHelper

  def show
    @drinks = drinks
  end

  def user_define
    @drinks = drinks
  end

  def record_user_define
    @drinks = drinks
  end
  
end

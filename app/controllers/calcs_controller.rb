class CalcsController < ApplicationController
  include CalcHelper
  
  # calc_page
  # 呈現估計結果
  def show
    @drinks = drinks
  end

end

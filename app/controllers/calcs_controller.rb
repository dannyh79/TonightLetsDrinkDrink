class CalcsController < ApplicationController
  include CalcsHelper
  
  # calc_page
  # 呈現估計結果
  def show
    @drinks = drinks
  end

end

Rails.application.routes.draw do

  # calc_page
  resource :calcs, only: [:show]  # 寫 helper 帶資料進去


end


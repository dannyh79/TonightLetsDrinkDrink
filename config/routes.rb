Rails.application.routes.draw do

  # landing_page
  root 'pages#index'

  # intro_page
  get '/intro', to: 'pages#intro'

  # nav_bar 關於我們
  get '/about', to: 'pages#about'

  # nav_bar 編輯調酒紀錄
  get '/user_define/edit', to: 'user_define#edit'

  # calc_page
  resources :calcs, only: [:index, :show]

  # member_system => devise gem

end

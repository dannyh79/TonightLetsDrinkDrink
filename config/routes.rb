Rails.application.routes.draw do
  
  # member_system => devise gem
  devise_for :users, controllers: { registrations: 'registrations' }
  
  # landing_page
  root 'pages#index'

  # nav_bar 關於我們
  get '/about', to: 'pages#about'

  # nav_bar 編輯調酒紀錄
  resource :user_define, only: [:edit, :destroy]

  # calc_page
  resource :calc, only: [:show] do
    member do
      get '/user_define', to: 'calcs#user_define'
      get '/record_user_define', to: 'calcs#record_user_define'
    end
  end

  # calc_page

end


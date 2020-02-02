Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               omniauth_callbacks: 'users/omniauth_callbacks',
               registrations: 'registrations'
             }

  devise_scope :user do
    get   '/profile',
          to: 'registrations#profile',
          as: :user_profile
    patch '/profile_update',
          to: 'registrations#profile_update',
          as: :update_user_profile
  end

  root 'pages#index'
  get  '/about', to: 'pages#about'

  resource :calc, only: [:show] do
    member do
      get '/user_define',        to: 'calcs#user_define'
      get '/record_user_define', to: 'calcs#record_user_define'
    end
  end

  # user_define
  resources :user_define, only: %i[create destroy]
  patch '/calc/user_define/add_ingredient',
        to: 'user_define#add_ingredient'
  patch '/calc/user_define/delete_ingredient/:id',
        to: 'user_define#delete_ingredient'
end

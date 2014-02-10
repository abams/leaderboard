Rails.application.routes.draw do
  root :to => 'pages#home'

  resources :games, only: [:new, :create, :index]
  resources :leagues, only: [:new, :create, :show, :destroy]
  resources :users, only: [:show, :edit, :update]

  get '/leaderboard' => 'leaderboards#index'
  get '/signup' => 'sessions#new'
  get '/login' => 'sessions#login'
  post '/login' => 'sessions#login_attempt'
  post '/sessions/create' => 'sessions#create'
  match '/signout' => 'sessions#destroy', :as => :signout, via: [:get, :post]
  match 'auth/failure' => 'sessions#failure', via: [:get, :post]
end

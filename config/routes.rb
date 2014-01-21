Rails.application.routes.draw do
  root :to => 'leaderboards#index'

  resources :matches, only: [:new, :create, :index]
  resources :leagues, only: [:new, :create, :show, :destroy]

  get '/leaderboard' => 'leaderboards#index'
  get '/sessions/new' => 'sessions#new'
  get '/login' => 'sessions#login'
  post '/login' => 'sessions#login_attempt'
  post '/sessions/create' => 'sessions#create'
  match '/signout' => 'sessions#destroy', :as => :signout, via: [:get, :post]
  match 'auth/failure' => 'sessions#failure', via: [:get, :post]
end

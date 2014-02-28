Rails.application.routes.draw do
  root :to => 'pages#home'

  resources :games, only: [:new, :create, :index]
  resources :users, only: [:edit, :update]
  resources :tournaments, except: :destroy

  get '/leaderboard' => 'leaderboards#index'
  get '/signup' => 'sessions#new'
  get '/login' => 'sessions#login'
  post '/login' => 'sessions#login_attempt'
  post '/sessions/create' => 'sessions#create'
  match '/signout' => 'sessions#destroy', :as => :signout, via: [:get, :post]
  match 'auth/failure' => 'sessions#failure', via: [:get, :post]

  namespace :api, defaults: { format: 'json' } do
    namespace :v1, defaults: { format: 'json' } do
      get '/leaderboard' => 'leaderboards#index'
      post '/login' => 'authentication#login'
      post '/signup' => 'authentication#signup'

      resources :games, only: [:new, :create]
    end
  end

  get '/:username', to: 'pages#profile', as: 'profile'
end

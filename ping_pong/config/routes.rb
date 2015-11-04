Rails.application.routes.draw do
  resources :games
  resources :players
  resources :sessions, only: [:create, :destroy, :new] 
  resources :teams
  resources :tables

  get '/signup', to: 'players#new'
  get '/login', to: 'sessions#new', as: 'log_in'
  get '/logout', to: 'sessions#destroy', as: 'log_out'

  root to: 'home#index'

end

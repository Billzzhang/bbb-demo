Rails.application.routes.draw do
  root 'meeting#home', as: 'home'
  
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
  post '/create', to: 'meeting#create', as: 'create'
  post '/delete', to: 'meeting#delete', as: 'delete'
  post '/join', to: 'meeting#join', as: 'join'
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
end

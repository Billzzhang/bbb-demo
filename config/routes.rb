Rails.application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]  get ‘signup’, to: ‘users#new’, as: ‘signup’
  get ‘login’, to: ‘sessions#new’, as: ‘login’
  get ‘logout’, to: ‘sessions#destroy’, as: ‘logout’
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'meeting#home', as: 'home'
  post '/create', to: 'meeting#create'
  post '/delete', to: 'meeting#delete'
end

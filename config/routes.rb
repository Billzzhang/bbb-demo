Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'meeting#home', as: 'home'
  post '/create', to: 'meeting#create'
  post '/delete', to: 'meeting#delete'
end

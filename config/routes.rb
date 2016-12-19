Rails.application.routes.draw do
  root to: 'home#index'
  get '/registration', to: 'registrations#new', as: 'new_registration'
  resources :users, only: [:create]
  resources :links, only: [:index]
end

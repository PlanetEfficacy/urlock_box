Rails.application.routes.draw do
  root to: 'home#index'
  get '/registration', to: 'registrations#new', as: 'new_registration'
  # post '/registration', to: 'registrations#create', as: 'registration'
end

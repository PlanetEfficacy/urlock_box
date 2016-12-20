Rails.application.routes.draw do
  root to: 'sessions#new'
  get '/registration', to: 'registrations#new', as: 'new_registration'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :users, only: [:create]
  resources :links, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :links, only: [:create, :index, :update]
    end
  end
end

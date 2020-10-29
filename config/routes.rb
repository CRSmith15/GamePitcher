Rails.application.routes.draw do
  root 'sessions#home'

  get '/signup' => 'users#new'

  resources :genres
  resources :comments
  resources :users
  resources :games
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

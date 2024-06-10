# frozen_string_literal: true

Rails.application.routes.draw do
  root "videos#index"

  resources :users, only: %i[create show]
  resources :videos, only: %i[create update destroy edit]

  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  get '/share', to: 'videos#new'

  resource :sessions, only: %i[create destroy]

  # Mount ActionCable server.
  mount ActionCable.server => '/cable'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

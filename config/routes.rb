Rails.application.routes.draw do
  resources :paths
  mount Sidekiq::Web => '/sidekiq'
  post "/graphql", to: "graphql#execute"

  root :to => 'application#home'

  namespace :api do
    resources :locations do
      get :current, on: :collection
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:show]
  resources :paths, only: [:index, :show, :create, :update, :destroy]
  resources :cities, only: [:index, :show, :new, :edit, :create, :update, :destroy]

  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end

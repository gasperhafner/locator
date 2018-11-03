Rails.application.routes.draw do
  resources :paths
  mount Sidekiq::Web => '/sidekiq'

  root :to => 'cities#index'

  namespace :api do
    namespace :v1 do
      resources :locations do
        get :current, on: :collection
      end
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:edit, :update, :new]
  resources :paths, only: [:index, :show, :create, :update, :destroy]
  resources :cities, only: [:index, :show, :new, :edit, :create, :update, :destroy]

  post "send_test_push", to:"users#send_test_push"
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end

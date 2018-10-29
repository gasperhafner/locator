Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  post "/graphql", to: "graphql#execute"

  namespace :api do
    resources :locations do
      get :current, on: :collection
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

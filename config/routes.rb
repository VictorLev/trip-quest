Rails.application.routes.draw do
  devise_for :users
  root to: "pages#dashboard"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  get "/account" => "users#show", as: :user
  patch "/account" => "users#update"

  resources :users, only: [] do
    resources :cars, only: [ :new, :create, :edit, :update]
  end
  resources :cars, only: [:destroy]

  resources :feeds, only: :show do
    resources :posts, only: :create
  end

end

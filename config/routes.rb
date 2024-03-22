Rails.application.routes.draw do
  get 'stimulus/flatpickr'
  get 'planned_routes/show'

  devise_for :users

  get "/" => "pages#home", as: :home
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"


  #this is a comment


  get "/dashboard" => "pages#dashboard", as: :dashboard

  get "/account" => "users#show", as: :user
  patch "/account" => "users#update"

  get "/strategic-points" => "pages#strategic_points", as: :strategic_points

  get "/feeds" => "feeds#index", as: :feeds
  get "/new_level" => "pages#new_level", as: :new_level


  resources :users, only: [] do
    resources :cars, only: [ :new, :create, :edit, :update]
    resources :planned_routes, only: [:new, :create, :edit, :update, :show, :index] do
      resources :projected_reward, only: [ :create]
    end
    resources :trips, only: [:create ]
  end
  resources :cars, only: [:destroy]
  resources :planned_routes, only: [:destroy]

  resources :feeds, only: :show do
    resources :posts, only: :create
  end

  resources :insurers, only: [:index]

  resources :trips, only: [ :index, :new, :show ] #insert under :cars resources due to the foreign key
end

Rails.application.routes.draw do
  namespace :api, default: { format: 'json' } do
    namespace :v1 do
      devise_for :api_users,
                 path: 'users',
                 controllers: {
                   sessions: 'api/v1/sessions',
                   registrations: 'api/v1/registrations'
                 }
      resources :users, only: [:index, :show]
      resources :blogs
    end
  end

  resources :posts do
    resources :comments
  end
  resources :sessions, only: [:new, :create, :destroy]
  get 'login', to:'sessions#new', as:'login'
  get 'logout', to:'sessions#destroy', as:'logout'
  resources :users
  root "home#index"
  get 'resume', to:'resume#index'
  
  get 'blogs/error', to:'blogs#error'
  resources :blogs, only: [:index, :show]
  get 'greeter', to:'greeter#hello'
  get 'greeter/goodbye', to:'greeter#goodbye'
  get 'match', to:'match#index'
  post 'match', to:'match#find'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  
end

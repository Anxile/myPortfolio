Rails.application.routes.draw do
  root "home#index"
  get 'resume', to: 'resume#index'

  resources :blogs, only: [:index, :show]
  get 'greeter', to: 'greeter#hello'
  get 'greeter/goodbye', to: 'greeter#goodbye'
  get "up" => "rails/health#show", as: :rails_health_check
end

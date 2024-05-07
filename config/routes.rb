Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :user do
        post 'sign_in', to: 'sessions#sign_in'
        delete 'sign_out', to: 'sessions#sign_out'
        get 'me', to: 'sessions#me'
      end
    end
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

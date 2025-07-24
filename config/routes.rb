
Rails.application.routes.draw do
  get "/products" ,to: "dashboards#summary"
  post "/add_products" , to: "dashboards#create"
  #patch "/products/:id", to: "dashboards#update"
  put "/products/:id", to: "dashboards#update"
  get "/products/:id/edit", to: "dashboards#edit"
  delete "/products/:id", to: "dashboards#destroy"
  post '/api/auth/google', to: 'api/sessions#google_login'

  devise_for :users , 
  controllers:{
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  },
   defaults: { format: :json }
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

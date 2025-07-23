Rails.application.routes.draw do
  get "/products" ,to: "dashboards#summary"
  post "/add_products" , to: "dashboards#create"
  post "/update_products", to: "dashboards#update"
  devise_for :users , 
  controllers:{
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
# config/routes.rb
match '*path', via: [:options], to: lambda { |_| [204, {}, ['']] }


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

Rails.application.routes.draw do
  root "home#index"

  get "" => "home#index", as: :home

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :admin do
    get "login", to: "auth#login", as: :login
    post "login", to: "auth#process_login", as: :login_post
    delete "logout", to: "auth#logout", as: :logout

    get "", to: "admin#dashboard", as: :dashboard

      resources :users

      resources :products do
        get "/", to: "products#index", as: :index
        # get "/:id", to: "products#show", as: :show
        # thêm các action khác...
      end
  end
end

Rails.application.routes.draw do
  get "password_resets/new"
  get "password_resets/create"
  get "password_resets/edit"
  get "password_resets/update"
  get "welcome/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker


 


  # Defines the root path route ("/")
  root "home#index"
  get "welcome", to: "welcome#index"
  get "about", to: "about#index"

  # Authentication
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get "sign_up", to: "registrations#new", as: :sign_up
post "sign_up", to: "registrations#create"
  
  # Dashboard
  get "dashboard", to: "home#dashboard"
  
  # Tweet management
  resources :tweets, except: [ :index ] do
    collection do
      get "scheduled", to: "tweets#scheduled"  # /tweets/scheduled
    end
  end
  

  get "password_reset", to: "password_resets#new", as: :new_password_reset
  post "password_reset", to: "password_resets#create"
  get "password_reset/edit", to: "password_resets#edit", as: :edit_password_reset
  patch "password_reset", to: "password_resets#update"
end

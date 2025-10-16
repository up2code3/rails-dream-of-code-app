# frozen_string_literal: true

Rails.application.routes.draw do
  resources :students
  resources :mentors
  resources :enrollments
  resources :mentor_enrollment_assignments
  resources :lessons
  resources :courses do
    resources :submissions
  end
  resources :coding_classes
  resources :trimesters

  # session routes for session controller AKA log in and out
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # Delete all these manual routes, resourceful ones above have us covered!
  get "/trimesters/:id/edit", to: "trimesters#edit"
  put "/trimesters/:id", to: "trimesters#update"
  get "/dashboard", to: "admin_dashboard#index"
  get "/courses/new", to: "courses#new"
  post "/courses", to: "courses#create"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # from lesson, see below --> resources seems cleaner (see above)
  # get '/trimesters', to: 'trimesters#index'
  # get '/trimesters/:id', to: 'trimesters#show'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  namespace :api do
    namespace :v1 do
      get "/courses", to: "courses#index"
      get "/courses/:course_id/enrollments", to: "enrollments#index"
      post "/students", to: "students#create"
    end
  end
  # Defines the root path route ("/")
  root "home#index"
end

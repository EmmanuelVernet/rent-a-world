Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "pages#home"

  # APP ROUTES

  # User routes (optional, if you need user-specific actions)
  # resources :users, only: [ :show ] do
  # Nested routes for user-specific bookings and reviews
  # resources :bookings, only: [ :index ]
  # resources :reviews, only: [ :index ]
  # end

  # World routes (main resource)
  resources :worlds do
    # Nested routes for bookings, reviews, and tags
    collection do
      get :my_worlds
    end
    resources :bookings, only: [ :index, :new, :create, :edit, :update, :show ] # for renter + rentee per world
    resources :reviews, only: [ :create, :index ]
    resources :tags, only: [ :index ] # To fetch tags for a specific world
  end

  # Tags routes (for global tags index or CRUD)
  # resources :tags, only: [ :index ]

  # WorldTag routes (for managing associations between worlds and tags)
  # resources :world_tags, only: [ :create, :destroy ]

  # Bookings routes
  resources :bookings do #, only: [ :index, :show, :update, :destroy ] # for rentee’s list & admin CRUD
    member do
      post :accept
      post :cancel
    end
  end

  # Reviews routes (for global access or management)
  # resources :reviews, only: [ :index, :show, :destroy ]
end

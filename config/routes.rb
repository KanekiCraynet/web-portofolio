Rails.application.routes.draw do
  # ============================================
  # Health Check
  # ============================================
  get "up" => "rails/health#show", as: :rails_health_check
  get "health" => "rails/health#show"

  # ============================================
  # PWA Routes
  # ============================================
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # ============================================
  # Root
  # ============================================
  root "home#index"

  # ============================================
  # Authentication (Custom Session-based)
  # ============================================
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # ============================================
  # Admin Namespace
  # ============================================
  namespace :admin do
    root "dashboard#index"

    resources :projects do
      member do
        patch :publish
        patch :unpublish
        patch :feature
        patch :unfeature
      end
    end

    resources :skills
    resources :experiences
    resources :blog_posts do
      member do
        patch :publish
        patch :unpublish
      end
    end
    resources :messages, only: [:index, :show, :destroy] do
      member do
        patch :mark_as_read
      end
    end

    # Settings
    get "settings", to: "settings#index"
    patch "settings", to: "settings#update"
  end

  # ============================================
  # API Namespace (v1)
  # ============================================
  namespace :api do
    namespace :v1 do
      resources :projects, only: [:index, :show]
      resources :skills, only: [:index]
      resources :experiences, only: [:index]
      resources :blog_posts, only: [:index, :show]

      # Contact API endpoint
      resources :messages, only: [:create]
    end
  end

  # ============================================
  # Public Routes
  # ============================================
  resources :projects, only: [:index, :show]
  resources :blog_posts, only: [:index, :show], path: "blog"

  # Static Pages
  get "about", to: "pages#about"
  get "contact", to: "pages#contact"

  # Contact Form Submission
  resources :messages, only: [:create]

  # ============================================
  # SEO Routes
  # ============================================
  get "sitemap.xml", to: "sitemaps#index", defaults: { format: "xml" }

  # ============================================
  # Catch-all for 404 (optional, handle in ApplicationController)
  # ============================================
  # match "*unmatched", to: "application#not_found", via: :all
end

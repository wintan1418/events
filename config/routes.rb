Rails.application.routes.draw do
  # === Devise ===
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords"
  }

  # === Health Check ===
  get "up" => "rails/health#show", as: :rails_health_check

  # === Sidekiq Web UI (admin only) ===
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  # === Root: role-based redirect ===
  authenticated :user do
    root to: "dashboard#show", as: :authenticated_root
  end
  root to: "pages#landing"

  # === Dashboard redirect ===
  get "dashboard", to: "dashboard#show", as: :dashboard

  # === Admin Namespace ===
  namespace :admin do
    get "dashboard", to: "dashboard#show"
    resource :account, only: [:show, :edit, :update]
    resources :users
    resources :events, only: [:index, :show]
    resources :vendors
  end

  # === Planner Namespace ===
  namespace :planner do
    get "dashboard", to: "dashboard#show"
    resources :events do
      resources :tasks, except: [:show]
      resources :event_vendors
      resources :line_items
      resources :guests do
        collection do
          get :export
        end
      end
      resources :timelines, except: [:show]
    end
    resources :vendors, only: [:index, :show]
  end

  # === Client Namespace ===
  namespace :client do
    get "dashboard", to: "dashboard#show"
    resources :events, only: [:index, :show] do
      resources :guests
      resources :line_items, only: [:index, :show]
      resources :timelines, only: [:index]
    end
  end

  # === Vendor Portal Namespace ===
  namespace :vendor_portal do
    get "dashboard", to: "dashboard#show"
    resources :events, only: [:index, :show] do
      resources :event_vendors, only: [:index, :show, :update]
    end
  end
end

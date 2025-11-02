Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

    unauthenticated do
      root to: "top#index", as: :unauthenticated_root
    end

    authenticated :user do
      root to: "home#index", as: :authenticated_root
    end

    resources :groups, only: [ :index, :new, :create, :show ] do
      resource :membership, only: [ :destroy ]
      resources :cheers, only: :create
    end

    resources :exercise_logs, only: [ :index, :new, :create ]

    resources :notifications, only: [ :index ]

  root "top#index"

  # 開発用（直接アクセスしたい時用）
  get :top,  to: "top#index"
  get :home, to: "home#index"

  get "stats/points/daily", to: "stats/points#daily", defaults: { format: :json }

  get  "invite/:token", to: "invites#show",   as: :invite
  post "invite/:token", to: "invites#accept", as: :accept_invite

  get "/privacy", to: "static_pages#privacy", as: :privacy
  get "/terms",   to: "static_pages#terms",   as: :terms

  get "up", to: "rails/health#show", as: :rails_health_check

  resource :mypage, only: [ :show, :edit, :update ]

  if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end

Rails.application.routes.draw do
  devise_for :users

    # 未ログイン → / (Top)
    unauthenticated do
      root to: "top#index", as: :unauthenticated_root
    end

    # ログイン済み → / (Home)
    authenticated :user do
      root to: "home#index", as: :authenticated_root
      resources :groups, only: [:index, :new, :create]
    end

  root "top#index"

  # 開発用（直接アクセスしたい時用）
  get :top,  to: "top#index"
  get :home, to: "home#index"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :records, only: [ :index, :new, :create, :show ]
  resource :mypage, only: [ :show, :edit, :update ]
end

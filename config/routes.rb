Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  # 公開トップページ
  root "top#index"

  resources :groups,  only: [ :index ]
  resources :records, only: [ :index, :new, :create, :show ]
  resource :mypage, only: [ :show, :edit, :update ]
end

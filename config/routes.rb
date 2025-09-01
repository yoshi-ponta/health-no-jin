Rails.application.routes.draw do
  get "records/index"
  get "records/new"
  get "records/show"
  get "up" => "rails/health#show", as: :rails_health_check
  # 公開トップページ
  root "top#index"

  resources :groups,  only: [:index]
  resources :records, only: [:index, :new, :create, :show]
end

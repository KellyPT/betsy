Rails.application.routes.draw do
  root 'sessions#index_log_out'

  resources :orders do
    resources :order_items, except: [:update, :destroy]
  end
  resources :products, only: [:index, :show] do
    resources :reviews
  end
  resources :merchants do
    resources :products
  end

  resources :categories, except: [:edit, :update, :destroy] do
    resources :products, only: [:index]
  end

  resources :order_items, only: [:update, :destroy]

  get "/auth/:provider/callback" =>  "sessions#create"
  get "/sessions/", to: "sessions#index_log_in", as: "sessions_log_in"
  get "/sessions/", to: "sessions#index_log_out", as: "sessions_log_out"
  delete "/sessions", to: "sessions#destroy"

end

Rails.application.routes.draw do
  root 'sessions#index_log_out'

  get "/orders/pending", to: 'orders#pending', as: 'pending_orders'
  get "/orders/paid", to: 'orders#paid', as: 'paid_orders'
  get "/orders/completed", to: 'orders#completed', as: 'completed_orders'
  get "/orders/cancelled", to: 'orders#cancelled', as: 'cancelled_orders'

  resources :orders do
    resources :order_items, except: [:update, :destroy, :show]
    resources :payment_details, only: [:new, :create]
  end

  resources :products, only: [:index, :show] do
    resources :reviews, only: [:new, :create]
  end


  resources :merchants, only: [:index, :show] do
    resources :products, except: [:destroy]
  end

  resources :categories, except: [:edit, :update, :destroy]

  resources :categories, except: [:edit, :update, :destroy]

  resources :order_items, only: [:update, :destroy, :show]

  resources :payment_details, only: [:show]

  get "/auth/:provider/callback" =>  "sessions#create"
  get "/sessions/", to: "sessions#index_log_in", as: "sessions_log_in"
  get "/sessions/", to: "sessions#index_log_out", as: "sessions_log_out"
  delete "/sessions", to: "sessions#destroy"
  get "/sessions/merchant_login", to: "sessions#merchant_login", as: "sessions_merchant_login"

  get "/cancel", to: "orders#cancel", as: "cancelled_order"
end

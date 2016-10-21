Rails.application.routes.draw do


  root 'sessions#index'
  resources :orders do
    resources :order_items, except: [:update, :destroy]
    resources :payment_details, only: [:new, :create]
  end
  resources :products, only: [:index, :show] do
    resources :reviews
  end
  resources :merchants do
    resources :products
  end

  resources :categories, except: [:edit, :update, :destroy]

  resources :order_items, only: [:update, :destroy]
  resources :payment_details, only: [:show]
end

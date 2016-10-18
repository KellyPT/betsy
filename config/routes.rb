Rails.application.routes.draw do


  root 'sessions#index'
  resources :orders do
    resources :order_items
  end
  resources :products, only: [:index, :show] do
    resources :reviews
  end
  resources :merchants do
    resources :products
  end
  resources :categories do
    resources :products, only: [:index, :show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

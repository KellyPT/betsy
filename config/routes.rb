Rails.application.routes.draw do
  resources :reviews
  resources :orders
  resources :products
  resources :merchants
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

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

  resources :categories, except: [:edit, :update, :delete]

  # get "auth/:provider" => "sessions#login"

  #Kelly: after log in Git Hub, a Merchant object and session[:merchant_id] will be created based on auth_hash data
  get "/auth/:provider/callback" =>  "sessions#create"

  #Kelly: if a Guest User didn't log in, redirect to creation failure view. This will never be called? If the user didn't log in, GitHub keeps asking for username and password.

  # Kelly: Right now login_failure template is not rendering. Question: should it be redirect to the homepage instead? Yes! If he didn't login, he will be rerouted to the homepage with the error message. The require_login method in Application Controller is doing this magic: redirecting straight to root path. Therefore, the below route is being ignored!
  get "/sessions/login_failure", to: "sessions#login_failure", as: "login_failure"

  #Kelly: after Merchant log in sucessfully, we display the index template. Question: should be homepage 2nd version or go straight to Merchant Log In page?
  get "/sessions/", to: "sessions#index", as: "sessions"

  #Kelly: when a Merchant log out successfully, call the destroy method to remove session[:merchant_id] and redirect to log in failure view. Question: should it be redirect to the homepage instead? Yes!
  delete "/sessions", to: "sessions#destroy"
end

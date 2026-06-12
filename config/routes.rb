Rails.application.routes.draw do
  get "support_requests/index"
  get "support_requests/update"
  get "admin" => "admin#index"

  get "up" => "rails/health#show",
      as: :rails_health_check
  resources :support_requests, only: %i[ index update ]

  resources :users
  resources :products

  resource :session

  resources :passwords, param: :token

  scope "(:locale)" do
    resources :orders
    resources :carts


    resources :line_items do
      member do
        patch :decrement
      end
    end



    root "store#index", as: :store_index, via: :all
  end
end

Rails.application.routes.draw do
  resources :orders
  resources :lineitems
  resources :carts
  root 'store#index', as: 'store_index'
  resources :products
end

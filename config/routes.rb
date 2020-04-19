Rails.application.routes.draw do
  root 'store#index', as: 'store_index'
  resources :products
end

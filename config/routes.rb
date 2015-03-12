Rails.application.routes.draw do
  get 'carts/show'
  devise_for :users
  resources :products, only: [:index, :show]
  root "products#index"
end

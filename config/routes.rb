Rails.application.routes.draw do
  namespace :webhooks do
    get '/bt_sub_merchant_status', to: 'braintreehooks#verify'
    post '/bt_sub_merchant_status', to: 'braintreehooks#merchant_status_update'
  end

  resources :artists, except: [:index]

  resources :addresses

  resource :transactions, only: [:new, :create]

  resource :cart, only: [:show] do
    put 'add/:product_id', to: 'carts#add', as: :add_to
    put 'remove/:product_id', to: 'carts#remove', as: :remove_from
  end

  devise_for :users, controllers: {registrations: 'users/registrations'}

  resources :products, only: [:index, :show]

  root "products#index"
end

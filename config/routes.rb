Rails.application.routes.draw do
  resource :cart, only: [:show] do
    put 'add/:movie_id', to: 'carts#add', as: :add_to
    put 'remove/:movie_id', to: 'carts#remove', as: :remove_from
  end

  devise_for :users

  resources :products, only: [:index, :show]

  root "products#index"
end

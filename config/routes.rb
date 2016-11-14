Rails.application.routes.draw do
  get 'carts/show'

  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :books do
    collection do
      get 'search'
    end
  end

  resources :users, only: [:update]

  resource :cart, only: [:show] do
    put 'add/:book_id', to: 'carts#add', as: :add_to
    put 'remove/:book_id', to: 'carts#remove', as: :remove_from
    get :sum_fee_json, on: :collection
  end

  root 'books#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

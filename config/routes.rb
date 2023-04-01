Rails.application.routes.draw do
  namespace :admin do
    resources :order_details, only: [:update]
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :sessions, only: [:new, :create, :destroy]
    
    root to: 'homes#top'
  end

  scope module: :public do
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :orders, only: [:new, :create, :index, :show]
    get 'orders/confirm'
    get 'orders/complete'
    
    resources :cart_items, only: [:index, :update, :destroy, :create]
    get 'cart_items/destroy_all'
    
    
    get 'customers/my_page', to: 'customers/#show'
    get 'customers/infomation/edit', to: 'customers/#edit'
    patch 'customers/infomation', to: 'customers/#update'
    get 'customers/confirm'
    patch 'customers/withdraw', to: 'customers/#withdraw'
    
    resources :sessions, only: [:new, :create, :destroy]
    resources :registrations, only: [:new, :create]
    resources :items, only: [:index, :show]
    root to: 'homes#top'
    get 'about'
    
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

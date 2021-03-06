Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "/dashboard", to: "pages#dashboard"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/dashboard", to: "pages#dashboard"
  resources :exhibitions, only: [:index, :show, :edit, :update, :destroy] do
    resources :bookings, only: [:index, :new, :create]
    resources :reviews, only: [:new, :create, :destroy]
    resources :favorites, only: [:create]
  end
  resources :favorites, only: [:destroy], as: "favorite_delete"
  resources :users do
    resources :friendships, only: [:new, :create, :index]
    resources :favorites, only: [:index]
  end
  resources :sites, only: [:show, :edit, :update, :destroy]
  get "/fav", to: "favorites#fav", as: "favorite"
  get "/ticket", to: "bookings#ticket", as: "ticket"
end

Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :exhibitions, only [:index, :show] do
    resources :favorites, only [:index, :new, :create, :destroy]
    resources :bookings, only [:index, :new, :create]
    resources :reviews, only [:new, :create, :destroy]
  end
  resources :users do
    resources :friendships, only [:new, :create]
  end
end

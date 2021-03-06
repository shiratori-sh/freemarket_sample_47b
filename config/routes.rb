Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks',
      registrations:      'users/registrations',
      sessions:      'users/sessions'
    }


  root to: 'items#index'
  resources :users do
    get 'profile'
  end
  resources :items do
    member do
      patch 'info_update'
    end
    resources :buys
  end
  resources :credit_cards

  resources :identifications, only: [:index]
  resources :logouts, only: [:index]
  resources :listings, only: [:index]
  resources :progressions, only: [:index]
  resources :completions, only: [:index]
  resources :purchases, only: [:index]
  resources :purchased, only: [:index]
  resources :search, only: [:index]
  resources :category, only: [:index, :show]
  resources :brand, only: [:index, :show]
end
